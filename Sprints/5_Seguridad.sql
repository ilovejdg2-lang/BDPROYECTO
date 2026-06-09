/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 5/7
   SEGURIDAD (ROLES, PERMISOS Y PROCEDIMIENTOS)
   Tablas Usuario y Bitacora: ver 2_CrearTablas.sql (ON FG_Seguridad)
   ============================================================================ */

-- USUARIO ADMIN (requerido por triggers de bitacora en sprint 6)
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Usuario_Insertar
    @nombre_usuario   VARCHAR(20),
    @correo_usuario   VARCHAR(100),
    @contrasena_plana VARCHAR(100),
    @rol              VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;
    IF @rol NOT IN ('Administrador', 'Profesor', 'Estudiante', 'Usuario')
    BEGIN
        RAISERROR('Error: Rol de usuario no valido.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Usuario WHERE nombre_usuario = @nombre_usuario)
    BEGIN
        RAISERROR('Error: Ya existe un usuario con ese nombre.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Usuario WHERE correo_usuario = @correo_usuario)
    BEGIN
        RAISERROR('Error: Ya existe un usuario con ese correo.', 16, 1);
        RETURN;
    END
    INSERT INTO Usuario (nombre_usuario, correo_usuario, contrasena_usuario, rol, activo)
    VALUES (@nombre_usuario, @correo_usuario,
            CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena_plana), 2),
            @rol, 1);
    SELECT SCOPE_IDENTITY() AS id_usuario_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Profesor_AsignarUsuario
    @codigo_interno_profesor INT,
    @id_usuario              INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario AND rol = 'Profesor')
    BEGIN
        RAISERROR('Error: El usuario no existe o no tiene rol Profesor.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Profesor WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: Ese usuario ya esta vinculado a otro profesor.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Estudiante WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: Ese usuario ya esta vinculado a un estudiante.', 16, 1);
        RETURN;
    END
    UPDATE Profesor SET id_usuario = @id_usuario WHERE codigo_interno_profesor = @codigo_interno_profesor;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Estudiante_AsignarUsuario
    @id_estudiante INT,
    @id_usuario    INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario AND rol = 'Estudiante')
    BEGIN
        RAISERROR('Error: El usuario no existe o no tiene rol Estudiante.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Estudiante WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: Ese usuario ya esta vinculado a otro estudiante.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Profesor WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: Ese usuario ya esta vinculado a un profesor.', 16, 1);
        RETURN;
    END
    UPDATE Estudiante SET id_usuario = @id_usuario WHERE id_estudiante = @id_estudiante;
END
GO

USE InstitutoTECNIC;
GO
EXEC sp_Usuario_Insertar @nombre_usuario = 'admin', @correo_usuario = 'admin@tecnic.cr', @contrasena_plana = 'Admin#2026', @rol = 'Administrador';
GO

-- ROLES DE BASE DE DATOS
USE InstitutoTECNIC;
GO
IF DATABASE_PRINCIPAL_ID('rol_administrador') IS NULL 
    CREATE ROLE rol_administrador;
GO

USE InstitutoTECNIC;
GO
IF DATABASE_PRINCIPAL_ID('rol_profesor') IS NULL 
    CREATE ROLE rol_profesor;
GO

USE InstitutoTECNIC;
GO
IF DATABASE_PRINCIPAL_ID('rol_estudiante') IS NULL 
    CREATE ROLE rol_estudiante;
GO

-- PERMISOS POR ROL
USE InstitutoTECNIC;
GO
GRANT CONTROL ON SCHEMA::dbo TO rol_administrador;
GO

USE InstitutoTECNIC;
GO
GRANT SELECT ON Asignatura TO rol_profesor;
GRANT SELECT ON BloqueHorario TO rol_profesor;
GRANT SELECT ON Horario TO rol_profesor;
GRANT SELECT ON HorarioAsignatura TO rol_profesor;
GRANT SELECT ON Estudiante TO rol_profesor;
GRANT SELECT ON Curso TO rol_profesor;
GRANT SELECT ON Ciclo TO rol_profesor;
GRANT SELECT ON Aula TO rol_profesor;
GRANT SELECT, INSERT, UPDATE ON NotaFinal TO rol_profesor;
GRANT SELECT, INSERT, UPDATE ON Asistencia TO rol_profesor;
GO

USE InstitutoTECNIC;
GO
GRANT SELECT ON Asignatura TO rol_estudiante;
GRANT SELECT ON BloqueHorario TO rol_estudiante;
GRANT SELECT ON Horario TO rol_estudiante;
GRANT SELECT ON HorarioAsignatura TO rol_estudiante;
GRANT SELECT ON NotaFinal TO rol_estudiante;
GRANT SELECT ON Usuario TO rol_profesor;
GRANT SELECT ON Usuario TO rol_estudiante;
GO

-- PROCEDIMIENTOS DE SEGURIDAD
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ValidarLogin
    @nombre_usuario VARCHAR(20),
    @contrasena     VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT u.id_usuario, u.nombre_usuario, u.rol, u.correo_usuario AS correo
    FROM Usuario u
    WHERE u.nombre_usuario = @nombre_usuario
      AND u.activo = 1
      AND u.contrasena_usuario = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena), 2);
    IF @@ROWCOUNT = 0
        RAISERROR('Error: Usuario o contraseña incorrectos.', 16, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_CambiarContrasena
    @id_usuario        INT,
    @contrasena_actual VARCHAR(100),
    @contrasena_nueva  VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 FROM Usuario 
        WHERE id_usuario = @id_usuario 
          AND contrasena_usuario = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena_actual), 2)
    )
    BEGIN
        RAISERROR('Error: Contraseña actual incorrecta.', 16, 1);
        RETURN;
    END
    UPDATE Usuario
    SET contrasena_usuario = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena_nueva), 2)
    WHERE id_usuario = @id_usuario;
    RAISERROR('Contraseña cambiada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_DesactivarUsuario
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: El usuario con ID %d no existe.', 16, 1, @id_usuario);
        RETURN;
    END
    UPDATE Usuario SET activo = 0 WHERE id_usuario = @id_usuario;
    RAISERROR('Usuario desactivado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
SELECT nombre_usuario, rol, activo FROM Usuario;
GO

