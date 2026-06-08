/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 5/7
   SEGURIDAD (ROLES, PERMISOS Y PROCEDIMIENTOS DE SEGURIDAD)
   ============================================================================ */

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
GRANT SELECT ON Horario TO rol_estudiante;
GRANT SELECT ON HorarioAsignatura TO rol_estudiante;
GRANT SELECT ON NotaFinal TO rol_estudiante;
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
    SELECT u.id_usuario, u.nombre_usuario, u.rol,
           COALESCE(p.correo_profesor, e.correo_estudiante) AS correo
    FROM Usuario u
    LEFT JOIN Profesor p ON u.codigo_interno_profesor = p.codigo_interno_profesor
    LEFT JOIN Estudiante e ON u.id_estudiante = e.id_estudiante
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

