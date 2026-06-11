/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 6/11
   SEGURIDAD 
   ============================================================================ */

-- CRUD: USUARIO

--Crear un usuario
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


-- Roles de administrador (control total sobre la base de datos)
USE InstitutoTECNIC;
GO
GRANT CONTROL ON SCHEMA::dbo TO rol_administrador;
GO

USE InstitutoTECNIC;
GO
GRANT SELECT ON Asignatura TO rol_profesor;
GRANT SELECT ON BloqueHorario TO rol_profesor;
GRANT SELECT ON AsignaturaProfesor TO rol_profesor;
GRANT SELECT ON Horario TO rol_profesor;
GRANT SELECT ON HorarioAsignatura TO rol_profesor;
GRANT SELECT ON Estudiante TO rol_profesor;
GRANT SELECT ON Curso TO rol_profesor;
GRANT SELECT ON Ciclo TO rol_profesor;
GRANT SELECT ON Aula TO rol_profesor;
GRANT SELECT, INSERT, UPDATE ON NotaFinal TO rol_profesor;
GRANT SELECT, INSERT, UPDATE ON Asistencia TO rol_profesor;
GO

-- Roles de estudiante (lectura de asignaturas, horarios y notas)
USE InstitutoTECNIC;
GO
GRANT SELECT ON Asignatura TO rol_estudiante;
GRANT SELECT ON BloqueHorario TO rol_estudiante;
GRANT SELECT ON AsignaturaProfesor TO rol_estudiante;
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
CREATE PROCEDURE sp_EstablecerContextoUsuario
    @nombre_usuario VARCHAR(20),
    @contrasena     VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_usuario INT;

    SELECT @id_usuario = u.id_usuario
    FROM Usuario u
    WHERE u.nombre_usuario = @nombre_usuario
      AND u.activo = 1
      AND u.contrasena_usuario = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena), 2);

    IF @id_usuario IS NULL
    BEGIN
        RAISERROR('Error: Usuario o contraseña incorrectos.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'id_usuario', @value = @id_usuario;

    SELECT u.id_usuario, u.nombre_usuario, u.rol, u.correo_usuario AS correo
    FROM Usuario u
    WHERE u.id_usuario = @id_usuario;
END
GO

--Consultar el login SQL, rol de base de datos y usuario logico actual
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_VerificarSesionActual
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_usuario_sesion INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);

    SELECT
        SUSER_NAME() AS login_sql_server,
        USER_NAME() AS usuario_base_datos,
        IS_MEMBER('rol_administrador') AS es_rol_administrador,
        IS_MEMBER('rol_profesor') AS es_rol_profesor,
        IS_MEMBER('rol_estudiante') AS es_rol_estudiante,
        @id_usuario_sesion AS id_usuario_sesion,
        u.nombre_usuario AS usuario_logico,
        u.rol AS rol_logico
    FROM (SELECT 1 AS x) s
    LEFT JOIN Usuario u ON u.id_usuario = @id_usuario_sesion;
END
GO

--Obtener un usuario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Usuario_Obtener
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: El usuario con ID %d no existe.', 16, 1, @id_usuario);
        RETURN;
    END
    SELECT id_usuario, nombre_usuario, correo_usuario, rol, activo, fecha_creacion
    FROM Usuario WHERE id_usuario = @id_usuario;
END
GO

--Actualizar un usuario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Usuario_Actualizar
    @id_usuario       INT,
    @correo_usuario   VARCHAR(100),
    @rol              VARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    IF @rol NOT IN ('Administrador', 'Profesor', 'Estudiante', 'Usuario')
    BEGIN
        RAISERROR('Error: Rol de usuario no valido.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: El usuario con ID %d no existe.', 16, 1, @id_usuario);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM Usuario
        WHERE correo_usuario = @correo_usuario AND id_usuario <> @id_usuario
    )
    BEGIN
        RAISERROR('Error: Ya existe otro usuario con ese correo.', 16, 1);
        RETURN;
    END

    UPDATE Usuario
    SET correo_usuario = @correo_usuario,
        rol = @rol
    WHERE id_usuario = @id_usuario;
END
GO

--Eliminar un usuario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Usuario_Eliminar
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: El usuario con ID %d no existe.', 16, 1, @id_usuario);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Profesor WHERE id_usuario = @id_usuario)
       OR EXISTS (SELECT 1 FROM Estudiante WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: No se puede eliminar el usuario porque esta vinculado a un profesor o estudiante.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Bitacora WHERE id_usuario = @id_usuario)
    BEGIN
        RAISERROR('Error: No se puede eliminar el usuario porque tiene registros en bitacora.', 16, 1);
        RETURN;
    END
    DELETE FROM Usuario WHERE id_usuario = @id_usuario;
END
GO

-- CRUD: BITACORA

--Obtener un registro de bitacora
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Bitacora_Obtener
    @id_bitacora INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Bitacora WHERE id_bitacora = @id_bitacora)
    BEGIN
        RAISERROR('Error: El registro de bitacora no existe.', 16, 1);
        RETURN;
    END
    SELECT b.id_bitacora, b.fecha_bitacora, b.accion, b.ip_equipo, b.id_usuario,
           u.nombre_usuario, u.rol
    FROM Bitacora b
    INNER JOIN Usuario u ON u.id_usuario = b.id_usuario
    WHERE b.id_bitacora = @id_bitacora;
END
GO

--Consultar bitacora con filtros
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Bitacora_Listar
    @id_usuario   INT = NULL,
    @fecha_desde  DATETIME = NULL,
    @fecha_hasta  DATETIME = NULL,
    @top          INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    IF @top IS NULL OR @top < 1
        SET @top = 50;

    SELECT TOP (@top)
           b.id_bitacora,
           b.fecha_bitacora,
           u.nombre_usuario,
           u.rol,
           b.accion,
           b.ip_equipo
    FROM Bitacora b
    INNER JOIN Usuario u ON u.id_usuario = b.id_usuario
    WHERE (@id_usuario IS NULL OR b.id_usuario = @id_usuario)
      AND (@fecha_desde IS NULL OR b.fecha_bitacora >= @fecha_desde)
      AND (@fecha_hasta IS NULL OR b.fecha_bitacora <= @fecha_hasta)
    ORDER BY b.fecha_bitacora DESC, b.id_bitacora DESC;
END
GO

--Consultar bitacora por rol
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Bitacora_ListarPorRol
    @rol VARCHAR(25),
    @top INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    IF @top IS NULL OR @top < 1
        SET @top = 50;

    SELECT TOP (@top)
           b.id_bitacora,
           b.fecha_bitacora,
           u.nombre_usuario,
           u.rol,
           b.accion,
           b.ip_equipo
    FROM Bitacora b
    INNER JOIN Usuario u ON u.id_usuario = b.id_usuario
    WHERE u.rol = @rol
    ORDER BY b.fecha_bitacora DESC, b.id_bitacora DESC;
END
GO

-- USUARIOS DE SQL SERVER VINCULADOS A ROLES
USE master;
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'tecnic_admin')
    CREATE LOGIN tecnic_admin WITH PASSWORD = 'Admin#2026', CHECK_POLICY = OFF;
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'tecnic_profesor')
    CREATE LOGIN tecnic_profesor WITH PASSWORD = 'Profe#2026', CHECK_POLICY = OFF;
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'tecnic_estudiante')
    CREATE LOGIN tecnic_estudiante WITH PASSWORD = 'Estu#2026', CHECK_POLICY = OFF;
GO

USE InstitutoTECNIC;
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'tecnic_admin')
    CREATE USER tecnic_admin FOR LOGIN tecnic_admin;
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'tecnic_profesor')
    CREATE USER tecnic_profesor FOR LOGIN tecnic_profesor;
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'tecnic_estudiante')
    CREATE USER tecnic_estudiante FOR LOGIN tecnic_estudiante;
GO

USE InstitutoTECNIC;
GO
ALTER ROLE rol_administrador ADD MEMBER tecnic_admin;
GO
ALTER ROLE rol_profesor ADD MEMBER tecnic_profesor;
GO
ALTER ROLE rol_estudiante ADD MEMBER tecnic_estudiante;
GO

-- Evitar que los usuarios operativos queden con db_owner por accidente
USE InstitutoTECNIC;
GO
IF IS_ROLEMEMBER('db_owner', 'tecnic_profesor') = 1
    ALTER ROLE db_owner DROP MEMBER tecnic_profesor;
GO
IF IS_ROLEMEMBER('db_owner', 'tecnic_estudiante') = 1
    ALTER ROLE db_owner DROP MEMBER tecnic_estudiante;
GO

USE InstitutoTECNIC;
GO
GRANT EXECUTE ON SCHEMA::dbo TO rol_administrador;
GRANT EXECUTE ON sp_ValidarLogin TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_EstablecerContextoUsuario TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_VerificarSesionActual TO rol_administrador, rol_profesor, rol_estudiante;
GO

-- Ejecucion explicita por rol, siguiendo el principio de minimo privilegio
USE InstitutoTECNIC;
GO
GRANT EXECUTE ON sp_AsignaturasPorBloque TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_ProfesorDeAsignatura TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_AsignaturasConPrerrequisitos TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_AulasVacias TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_AsignaturasPorCicloCurso TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_HorarioCompleto TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_TutoresPorCurso TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_AsignaturasPorEstudiante TO rol_estudiante;
GRANT EXECUTE ON sp_NotasFinalesPorEstudiante TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_ResumenNotasEstudiante TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_EstudiantesPorAsignatura TO rol_profesor;
GRANT EXECUTE ON sp_ResumenAsistenciaEstudiante TO rol_profesor;
GRANT EXECUTE ON sp_AsignaturaProfesor_ConsultarAntiguedad TO rol_profesor;
GRANT EXECUTE ON sp_ProcesoMatricula_EstudianteInscribir TO rol_estudiante;
GRANT EXECUTE ON sp_ProcesoMatricula_ProfesorEvaluarEstudiante TO rol_profesor;
GRANT EXECUTE ON sp_NotaFinal_Insertar TO rol_profesor;
GRANT EXECUTE ON sp_NotaFinal_Actualizar TO rol_profesor;
GRANT EXECUTE ON sp_NotaFinal_Obtener TO rol_profesor, rol_estudiante;
GRANT EXECUTE ON sp_Asistencia_Insertar TO rol_profesor;
GRANT EXECUTE ON sp_Asistencia_Actualizar TO rol_profesor;
GRANT EXECUTE ON sp_Asistencia_Obtener TO rol_profesor;
GO

-- Respaldo completo de la base de datos
DECLARE @backupFileName NVARCHAR(250);

SET @backupFileName = 'C:\SqlBackup\InstitutoTECNIC_FULL_'
    + CONVERT(NVARCHAR(20), GETDATE(), 112)
    + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 108), ':', '')
    + '.bak';

BACKUP DATABASE [InstitutoTECNIC]
TO DISK = @backupFileName
WITH DESCRIPTION = N'Backup Completo - InstitutoTECNIC',
     NOFORMAT,
     NOINIT,
     NAME = N'InstitutoTECNIC-Full Database Backup',
     SKIP,
     NOREWIND,
     NOUNLOAD,
     STATS = 10;
GO
