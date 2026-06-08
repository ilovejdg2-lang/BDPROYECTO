/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 5/7
   PROCEDIMIENTOS ALMACENADOS (CRUD)
   ============================================================================ */

-- CRUD: SEDE
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Insertar
    @nombre_sede    NVARCHAR(100),
    @direccion_sede NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Sede (nombre_sede, direccion_sede)
    VALUES (@nombre_sede, @direccion_sede);
    SELECT SCOPE_IDENTITY() AS id_sede_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Actualizar
    @id_sede        INT,
    @nombre_sede    NVARCHAR(100),
    @direccion_sede NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede con ID %d no existe.', 16, 1, @id_sede);
        RETURN;
    END
    UPDATE Sede
       SET nombre_sede = @nombre_sede,
           direccion_sede = @direccion_sede
     WHERE id_sede = @id_sede;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Eliminar
    @id_sede INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Aula WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: No se puede eliminar la sede porque tiene aulas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Sede WHERE id_sede = @id_sede;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_sede, nombre_sede, direccion_sede FROM Sede ORDER BY nombre_sede;
END
GO

-- CRUD: CICLO
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Insertar
    @nombre_ciclo NVARCHAR(100),
    @categoria    NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @categoria NOT IN (N'Grado Medio', N'Grado Superior', N'Bachillerato Técnico')
    BEGIN
        RAISERROR('Error: La categoria "%s" no es valida.', 16, 1, @categoria);
        RETURN;
    END
    INSERT INTO Ciclo (nombre_ciclo, categoria)
    VALUES (@nombre_ciclo, @categoria);
    SELECT SCOPE_IDENTITY() AS codigo_interno_ciclo_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Actualizar
    @codigo_interno_ciclo INT,
    @nombre_ciclo         NVARCHAR(100),
    @categoria            NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Ciclo
       SET nombre_ciclo = @nombre_ciclo,
           categoria    = @categoria
     WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_ciclo, nombre_ciclo, categoria FROM Ciclo ORDER BY nombre_ciclo;
END
GO

-- CRUD: CURSO
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Insertar
    @nivel_curso          NVARCHAR(25),
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @nivel_curso NOT IN (N'Primer Año', N'Segundo Año', N'Tercer Año')
    BEGIN
        RAISERROR('Error: El nivel de curso no es valido.', 16, 1);
        RETURN;
    END
    INSERT INTO Curso (nivel_curso, codigo_interno_ciclo)
    VALUES (@nivel_curso, @codigo_interno_ciclo);
    SELECT SCOPE_IDENTITY() AS id_curso_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Actualizar
    @id_curso             INT,
    @nivel_curso          NVARCHAR(25),
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Curso
       SET nivel_curso = @nivel_curso,
           codigo_interno_ciclo = @codigo_interno_ciclo
     WHERE id_curso = @id_curso;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.id_curso, c.nivel_curso, c.codigo_interno_ciclo, ci.nombre_ciclo
    FROM Curso c
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    ORDER BY ci.nombre_ciclo, c.nivel_curso;
END
GO

-- CRUD: PROFESOR
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Insertar
    @cedula_profesor        VARCHAR(20),
    @nombre_profesor        NVARCHAR(50),
    @apellido1_profesor     NVARCHAR(50),
    @apellido2_profesor     NVARCHAR(50) = NULL,
    @correo_profesor        NVARCHAR(100) = NULL,
    @telefono_profesor      VARCHAR(20) = NULL,
    @seguro_social_profesor VARCHAR(30) = NULL,
    @direccion              NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Profesor (cedula_profesor, nombre_profesor, apellido1_profesor,
                        apellido2_profesor, correo_profesor, telefono_profesor,
                        seguro_social_profesor, direccion)
    VALUES (@cedula_profesor, @nombre_profesor, @apellido1_profesor,
            @apellido2_profesor, @correo_profesor, @telefono_profesor,
            @seguro_social_profesor, @direccion);
    SELECT SCOPE_IDENTITY() AS codigo_interno_profesor_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_profesor, cedula_profesor, nombre_profesor,
           apellido1_profesor, apellido2_profesor, correo_profesor, telefono_profesor, direccion
    FROM Profesor
    ORDER BY nombre_profesor;
END
GO

-- CRUD: AULA
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_Insertar
    @numero_aula        INT,
    @nombre_aula        NVARCHAR(100),
    @capacidad          INT,
    @metros_cuadrados   DECIMAL(8,2),
    @tiene_proyector    BIT,
    @id_sede            INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Aula (numero_aula, nombre_aula, capacidad, metros_cuadrados, tiene_proyector, id_sede)
    VALUES (@numero_aula, @nombre_aula, @capacidad, @metros_cuadrados, @tiene_proyector, @id_sede);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.numero_aula, s.nombre_sede, a.nombre_aula, a.capacidad,
           a.metros_cuadrados, a.tiene_proyector
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    ORDER BY s.nombre_sede, a.numero_aula;
END
GO

-- CRUD: ASIGNATURA
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Insertar
    @codigo_oficial            VARCHAR(20),
    @nombre_asignatura         NVARCHAR(100),
    @duracion_horas_asignatura INT,
    @codigo_interno_profesor   INT,
    @id_aula                   INT,
    @fecha_inicio_imparticion_profe DATE = NULL,
    @id_curso                  INT = NULL,
    @codigo_interno_ciclo      INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @duracion_horas_asignatura <= 0
    BEGIN
        RAISERROR('Error: La duracion en horas debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    BEGIN TRANSACTION;
    DECLARE @codigo_interno_asignatura INT;

    INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas_asignatura,
                            codigo_interno_profesor, id_aula, fecha_inicio_imparticion_profe)
    VALUES (@codigo_oficial, @nombre_asignatura, @duracion_horas_asignatura,
            @codigo_interno_profesor, @id_aula, @fecha_inicio_imparticion_profe);
    SET @codigo_interno_asignatura = SCOPE_IDENTITY();

    IF @id_curso IS NOT NULL
        INSERT INTO AsignaturaCurso (codigo_interno_asignatura, id_curso)
        VALUES (@codigo_interno_asignatura, @id_curso);

    IF @codigo_interno_ciclo IS NOT NULL
        INSERT INTO AsignaturaCiclo (codigo_interno_asignatura, codigo_interno_ciclo)
        VALUES (@codigo_interno_asignatura, @codigo_interno_ciclo);

    COMMIT TRANSACTION;
    SELECT @codigo_interno_asignatura AS codigo_interno_asignatura_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.codigo_oficial, a.nombre_asignatura,
           a.duracion_horas_asignatura, p.nombre_profesor, au.nombre_aula
    FROM Asignatura a
    JOIN Profesor p ON a.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula au ON a.id_aula = au.id_aula
    ORDER BY a.nombre_asignatura;
END
GO

-- CRUD: ESTUDIANTE
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Insertar
    @cedula_estudiante    VARCHAR(20),
    @nombre_estudiante    NVARCHAR(50),
    @apellido1_estudiante NVARCHAR(50),
    @apellido2_estudiante NVARCHAR(50) = NULL,
    @correo_estudiante    NVARCHAR(100) = NULL,
    @telefono_estudiante  VARCHAR(20) = NULL,
    @fecha_nacimiento     DATE = NULL,
    @fecha_ingreso        DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, apellido1_estudiante,
                            apellido2_estudiante, correo_estudiante, telefono_estudiante,
                            fecha_nacimiento, fecha_ingreso)
    VALUES (@cedula_estudiante, @nombre_estudiante, @apellido1_estudiante,
            @apellido2_estudiante, @correo_estudiante, @telefono_estudiante,
            @fecha_nacimiento, @fecha_ingreso);
    SELECT SCOPE_IDENTITY() AS id_estudiante_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_estudiante, cedula_estudiante, nombre_estudiante, apellido1_estudiante,
           apellido2_estudiante, correo_estudiante, telefono_estudiante, fecha_ingreso
    FROM Estudiante
    ORDER BY nombre_estudiante;
END
GO

-- CRUD: HORARIO + HORARIOASIGNATURA
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_Insertar
    @hora_inicio_bloque TIME,
    @hora_fin_bloque    TIME,
    @dia_semana         NVARCHAR(15),
    @num_bloque         INT,
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN (N'Lunes', N'Martes', N'Miércoles', N'Jueves', N'Viernes', N'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
       OR @hora_fin_bloque <= @hora_inicio_bloque
    BEGIN
        RAISERROR('Error: Datos de horario no validos.', 16, 1);
        RETURN;
    END
    BEGIN TRANSACTION;
    DECLARE @id_horario INT;

    INSERT INTO Horario (hora_inicio_bloque, hora_fin_bloque, dia_semana, num_bloque)
    VALUES (@hora_inicio_bloque, @hora_fin_bloque, @dia_semana, @num_bloque);
    SET @id_horario = SCOPE_IDENTITY();

    INSERT INTO HorarioAsignatura (id_horario, codigo_interno_asignatura)
    VALUES (@id_horario, @codigo_interno_asignatura);

    COMMIT TRANSACTION;
    SELECT @id_horario AS id_horario_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_ListarPorProfesor
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.id_horario, h.dia_semana, h.num_bloque, h.hora_inicio_bloque, h.hora_fin_bloque,
           au.nombre_aula, a.nombre_asignatura
    FROM Horario h
    JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
    JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Aula au ON a.id_aula = au.id_aula
    WHERE a.codigo_interno_profesor = @codigo_interno_profesor
    ORDER BY h.dia_semana, h.num_bloque;
END
GO

-- CRUD: PRERREQUISITO
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Prerrequisito_Insertar
    @codigo_interno_asignatura          INT,
    @codigo_oficial_asignatura_prerequerida VARCHAR(20),
    @nombre_asignatura_prerequisito     NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    DECLARE @id_prerrequisito INT;

    INSERT INTO Prerrequisito (codigo_oficial_asignatura_prerequerida, estado_prerrequisito, nombre_asignatura_prerequisito)
    VALUES (@codigo_oficial_asignatura_prerequerida, N'Activo', @nombre_asignatura_prerequisito);
    SET @id_prerrequisito = SCOPE_IDENTITY();

    INSERT INTO AsignaturaPrerrequisito (codigo_interno_asignatura, id_prerrequisito)
    VALUES (@codigo_interno_asignatura, @id_prerrequisito);

    COMMIT TRANSACTION;
    SELECT @id_prerrequisito AS id_prerrequisito_creado;
END
GO

-- MATRICULAR ESTUDIANTE
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_MatricularEstudiante
    @id_estudiante INT,
    @asignaturas   VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @id_matricula INT;

        INSERT INTO Matricula (fecha_matricula, estado_matricula, id_estudiante)
        VALUES (GETDATE(), N'Activa', @id_estudiante);
        SET @id_matricula = SCOPE_IDENTITY();

        INSERT INTO AsignaturaMatricula (codigo_interno_asignatura, id_matricula)
        SELECT TRY_CAST(value AS INT), @id_matricula
        FROM STRING_SPLIT(@asignaturas, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL;

        COMMIT TRANSACTION;
        SELECT @id_matricula AS id_matricula_creada;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        RAISERROR('Error al matricular: %s', 16, 1, ERROR_MESSAGE());
    END CATCH
END
GO

-- AULAS DISPONIBLES
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AulasDisponibles
    @dia_semana NVARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN (N'Lunes', N'Martes', N'Miércoles', N'Jueves', N'Viernes', N'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: Dia o bloque no valido.', 16, 1);
        RETURN;
    END
    SELECT a.numero_aula, s.nombre_sede, a.nombre_aula, a.capacidad
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    WHERE NOT EXISTS (
        SELECT 1
        FROM Horario h
        JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
        JOIN Asignatura asig ON ha.codigo_interno_asignatura = asig.codigo_interno_asignatura
        WHERE asig.id_aula = a.id_aula
          AND h.dia_semana = @dia_semana
          AND h.num_bloque = @num_bloque
    )
    ORDER BY s.nombre_sede, a.numero_aula;
END
GO

USE InstitutoTECNIC;
GO
SELECT COUNT(*) AS total_procedimientos FROM sys.procedures;
GO
