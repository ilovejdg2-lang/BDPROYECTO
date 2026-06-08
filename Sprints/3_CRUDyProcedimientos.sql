/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 3/7
   PROCEDIMIENTOS ALMACENADOS (CRUD + CONSULTAS CON JOINS)
   ============================================================================ */

-- CRUD: SEDE
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Sede_Insertar
    @nombre_sede    VARCHAR(100),
    @direccion_sede VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    IF LTRIM(RTRIM(@nombre_sede)) = '' OR LTRIM(RTRIM(@direccion_sede)) = ''
    BEGIN
        RAISERROR('Error: Nombre y direccion de sede son obligatorios.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Sede WHERE nombre_sede = @nombre_sede)
    BEGIN
        RAISERROR('Error: Ya existe una sede con ese nombre.', 16, 1);
        RETURN;
    END
    INSERT INTO Sede (nombre_sede, direccion_sede)
    VALUES (@nombre_sede, @direccion_sede);
    SELECT SCOPE_IDENTITY() AS id_sede_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Sede_Actualizar
    @id_sede        INT,
    @nombre_sede    VARCHAR(100),
    @direccion_sede VARCHAR(200)
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
CREATE PROCEDURE sp_Sede_Eliminar
    @id_sede INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede con ID %d no existe.', 16, 1, @id_sede);
        RETURN;
    END
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
CREATE PROCEDURE sp_Sede_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_sede, nombre_sede, direccion_sede FROM Sede ORDER BY nombre_sede;
END
GO

-- CRUD: CICLO
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Insertar
    @nombre_ciclo VARCHAR(100),
    @categoria    VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @categoria NOT IN ('Grado Medio', 'Grado Superior', 'Bachillerato Técnico')
    BEGIN
        RAISERROR('Error: La categoria no es valida.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Ciclo WHERE nombre_ciclo = @nombre_ciclo)
    BEGIN
        RAISERROR('Error: Ya existe un ciclo con ese nombre.', 16, 1);
        RETURN;
    END
    INSERT INTO Ciclo (nombre_ciclo, categoria)
    VALUES (@nombre_ciclo, @categoria);
    SELECT SCOPE_IDENTITY() AS codigo_interno_ciclo_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Actualizar
    @codigo_interno_ciclo INT,
    @nombre_ciclo         VARCHAR(100),
    @categoria            VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    IF @categoria NOT IN ('Grado Medio', 'Grado Superior', 'Bachillerato Técnico')
    BEGIN
        RAISERROR('Error: La categoria no es valida.', 16, 1);
        RETURN;
    END
    UPDATE Ciclo
       SET nombre_ciclo = @nombre_ciclo,
           categoria    = @categoria
     WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_ciclo, nombre_ciclo, categoria FROM Ciclo ORDER BY nombre_ciclo;
END
GO

-- CRUD: CURSO
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Curso_Insertar
    @nivel_curso          VARCHAR(25),
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @nivel_curso NOT IN ('Primer Año', 'Segundo Año', 'Tercer Año')
    BEGIN
        RAISERROR('Error: El nivel de curso no es valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo indicado no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO Curso (nivel_curso, codigo_interno_ciclo)
    VALUES (@nivel_curso, @codigo_interno_ciclo);
    SELECT SCOPE_IDENTITY() AS id_curso_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Curso_Actualizar
    @id_curso             INT,
    @nivel_curso          VARCHAR(25),
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    UPDATE Curso
       SET nivel_curso = @nivel_curso,
           codigo_interno_ciclo = @codigo_interno_ciclo
     WHERE id_curso = @id_curso;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Curso_Listar
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
CREATE PROCEDURE sp_Profesor_Insertar
    @cedula_profesor        VARCHAR(20),
    @nombre_profesor        VARCHAR(50),
    @apellido1_profesor     VARCHAR(50),
    @apellido2_profesor     VARCHAR(50) = NULL,
    @correo_profesor        VARCHAR(100) = NULL,
    @telefono_profesor      VARCHAR(20) = NULL,
    @seguro_social_profesor INT = NULL,
    @direccion              VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Profesor WHERE cedula_profesor = @cedula_profesor)
    BEGIN
        RAISERROR('Error: Ya existe un profesor con esa cedula.', 16, 1);
        RETURN;
    END
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
CREATE PROCEDURE sp_Profesor_Listar
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
CREATE PROCEDURE sp_Aula_Insertar
    @numero_aula        INT,
    @nombre_aula        VARCHAR(100),
    @capacidad          INT,
    @metros_cuadrados   DECIMAL(8,2),
    @tiene_proyector    BIT,
    @id_sede            INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede indicada no existe.', 16, 1);
        RETURN;
    END
    IF @capacidad <= 0 OR @metros_cuadrados <= 0
    BEGIN
        RAISERROR('Error: Capacidad y metros cuadrados deben ser mayores a 0.', 16, 1);
        RETURN;
    END
    INSERT INTO Aula (numero_aula, nombre_aula, capacidad, metros_cuadrados, tiene_proyector, id_sede)
    VALUES (@numero_aula, @nombre_aula, @capacidad, @metros_cuadrados, @tiene_proyector, @id_sede);
    SELECT SCOPE_IDENTITY() AS id_aula_creada;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Aula_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.id_aula, a.numero_aula, s.nombre_sede, a.nombre_aula, a.capacidad,
           a.metros_cuadrados, a.tiene_proyector
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    ORDER BY s.nombre_sede, a.numero_aula;
END
GO

-- CRUD: ASIGNATURA
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Insertar
    @codigo_oficial                 VARCHAR(20),
    @nombre_asignatura              VARCHAR(100),
    @duracion_horas_asignatura      INT,
    @codigo_interno_profesor        INT,
    @id_aula                        INT,
    @antiguedad_profesor            INT = NULL,
    @fecha_inicio_imparticion_profe   DATE = NULL,
    @fecha_fin_imparticion_profe    DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @duracion_horas_asignatura <= 0
    BEGIN
        RAISERROR('Error: La duracion en horas debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor indicado no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula indicada no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas_asignatura,
                            antiguedad_profesor, fecha_inicio_imparticion_profe,
                            fecha_fin_imparticion_profe, codigo_interno_profesor, id_aula)
    VALUES (@codigo_oficial, @nombre_asignatura, @duracion_horas_asignatura,
            @antiguedad_profesor, @fecha_inicio_imparticion_profe,
            @fecha_fin_imparticion_profe, @codigo_interno_profesor, @id_aula);
    SELECT SCOPE_IDENTITY() AS codigo_interno_asignatura_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCiclo_Insertar
    @codigo_interno_asignatura INT,
    @codigo_interno_ciclo      INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: Asignatura o ciclo no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO AsignaturaCiclo (codigo_interno_asignatura, codigo_interno_ciclo)
    VALUES (@codigo_interno_asignatura, @codigo_interno_ciclo);
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCurso_Insertar
    @codigo_interno_asignatura INT,
    @id_curso                  INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: Asignatura o curso no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO AsignaturaCurso (codigo_interno_asignatura, id_curso)
    VALUES (@codigo_interno_asignatura, @id_curso);
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Listar
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
CREATE PROCEDURE sp_Estudiante_Insertar
    @cedula_estudiante        VARCHAR(20),
    @nombre_estudiante        VARCHAR(50),
    @apellido1_estudiante     VARCHAR(50),
    @apellido2_estudiante     VARCHAR(50) = NULL,
    @seguro_social_estudiante INT = NULL,
    @correo_estudiante        VARCHAR(100) = NULL,
    @telefono_estudiante      VARCHAR(20) = NULL,
    @fecha_nacimiento         DATE = NULL,
    @fecha_ingreso            DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Estudiante WHERE cedula_estudiante = @cedula_estudiante)
    BEGIN
        RAISERROR('Error: Ya existe un estudiante con esa cedula.', 16, 1);
        RETURN;
    END
    IF @fecha_nacimiento IS NOT NULL AND @fecha_ingreso IS NOT NULL AND @fecha_ingreso <= @fecha_nacimiento
    BEGIN
        RAISERROR('Error: La fecha de ingreso debe ser posterior a la de nacimiento.', 16, 1);
        RETURN;
    END
    INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, apellido1_estudiante,
                            apellido2_estudiante, seguro_social_estudiante, correo_estudiante,
                            telefono_estudiante, fecha_nacimiento, fecha_ingreso)
    VALUES (@cedula_estudiante, @nombre_estudiante, @apellido1_estudiante,
            @apellido2_estudiante, @seguro_social_estudiante, @correo_estudiante,
            @telefono_estudiante, @fecha_nacimiento, COALESCE(@fecha_ingreso, CAST(GETDATE() AS DATE)));
    SELECT SCOPE_IDENTITY() AS id_estudiante_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Estudiante_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_estudiante, cedula_estudiante, nombre_estudiante, apellido1_estudiante,
           apellido2_estudiante, correo_estudiante, telefono_estudiante, fecha_ingreso
    FROM Estudiante
    ORDER BY nombre_estudiante;
END
GO

-- CRUD: HORARIO
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioBloque_Insertar
    @hora_inicio_bloque TIME,
    @hora_fin_bloque    TIME,
    @dia_semana         VARCHAR(15),
    @num_bloque         INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
       OR @hora_fin_bloque <= @hora_inicio_bloque
    BEGIN
        RAISERROR('Error: Datos de horario no validos.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Horario WHERE dia_semana = @dia_semana AND num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: Ya existe un bloque horario para ese dia y numero de bloque.', 16, 1);
        RETURN;
    END
    INSERT INTO Horario (hora_inicio_bloque, hora_fin_bloque, dia_semana, num_bloque)
    VALUES (@hora_inicio_bloque, @hora_fin_bloque, @dia_semana, @num_bloque);
    SELECT SCOPE_IDENTITY() AS id_horario_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioAsignatura_Asignar
    @id_horario                INT,
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Horario WHERE id_horario = @id_horario)
       OR NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: Horario o asignatura no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO HorarioAsignatura (id_horario, codigo_interno_asignatura)
    VALUES (@id_horario, @codigo_interno_asignatura);
    SELECT SCOPE_IDENTITY() AS id_horario_asignatura_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Horario_ListarPorProfesor
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
CREATE PROCEDURE sp_Prerrequisito_Insertar
    @codigo_oficial_asignatura_prerequerida VARCHAR(20),
    @nombre_asignatura_prerequisito         VARCHAR(100),
    @estado_prerrequisito                   VARCHAR(20) = 'Activo'
AS
BEGIN
    SET NOCOUNT ON;
    IF @estado_prerrequisito NOT IN ('Activo', 'Inactivo', 'Eliminado')
    BEGIN
        RAISERROR('Error: Estado de prerrequisito no valido.', 16, 1);
        RETURN;
    END
    INSERT INTO Prerrequisito (codigo_oficial_asignatura_prerequerida, estado_prerrequisito, nombre_asignatura_prerequisito)
    VALUES (@codigo_oficial_asignatura_prerequerida, @estado_prerrequisito, @nombre_asignatura_prerequisito);
    SELECT SCOPE_IDENTITY() AS id_prerrequisito_creado;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaPrerrequisito_Asignar
    @codigo_interno_asignatura INT,
    @id_prerrequisito          INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: Asignatura o prerrequisito no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO AsignaturaPrerrequisito (codigo_interno_asignatura, id_prerrequisito)
    VALUES (@codigo_interno_asignatura, @id_prerrequisito);
END
GO

-- CRUD: PERIODO
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Periodo_Insertar
    @nombre_periodo VARCHAR(50),
    @annio          INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @annio < 2000 OR @annio > 2100
    BEGIN
        RAISERROR('Error: El annio del periodo no es valido.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Periodo WHERE nombre_periodo = @nombre_periodo)
    BEGIN
        RAISERROR('Error: Ya existe un periodo con ese nombre.', 16, 1);
        RETURN;
    END
    INSERT INTO Periodo (nombre_periodo, annio)
    VALUES (@nombre_periodo, @annio);
    SELECT SCOPE_IDENTITY() AS id_periodo_creado;
END
GO

-- CRUD: MATRICULA
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Matricula_Insertar
    @id_estudiante    INT,
    @id_sede          INT,
    @fecha_matricula  DATETIME = NULL,
    @estado_matricula VARCHAR(20) = 'Activa'
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede indicada no existe.', 16, 1);
        RETURN;
    END
    IF @estado_matricula NOT IN ('Activa', 'Anulada', 'Finalizada')
    BEGIN
        RAISERROR('Error: Estado de matricula no valido.', 16, 1);
        RETURN;
    END
    INSERT INTO Matricula (fecha_matricula, estado_matricula, id_estudiante, id_sede)
    VALUES (COALESCE(@fecha_matricula, GETDATE()), @estado_matricula, @id_estudiante, @id_sede);
    SELECT SCOPE_IDENTITY() AS id_matricula_creada;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaMatricula_Insertar
    @codigo_interno_asignatura INT,
    @id_matricula              INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: Asignatura o matricula no existe.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1
        FROM Matricula m
        JOIN Asignatura a ON a.codigo_interno_asignatura = @codigo_interno_asignatura
        JOIN Aula au ON a.id_aula = au.id_aula
        WHERE m.id_matricula = @id_matricula
          AND m.id_sede <> au.id_sede
    )
    BEGIN
        RAISERROR('Error: La asignatura no pertenece a la sede de la matricula.', 16, 1);
        RETURN;
    END
    INSERT INTO AsignaturaMatricula (codigo_interno_asignatura, id_matricula)
    VALUES (@codigo_interno_asignatura, @id_matricula);
    SELECT SCOPE_IDENTITY() AS id_asignatura_matricula_creada;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_MatricularEstudiante
    @id_estudiante INT,
    @id_sede       INT,
    @asignaturas   VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede indicada no existe.', 16, 1);
        RETURN;
    END
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @id_matricula INT;

        INSERT INTO Matricula (fecha_matricula, estado_matricula, id_estudiante, id_sede)
        VALUES (GETDATE(), 'Activa', @id_estudiante, @id_sede);
        SET @id_matricula = SCOPE_IDENTITY();

        INSERT INTO AsignaturaMatricula (codigo_interno_asignatura, id_matricula)
        SELECT TRY_CAST(value AS INT), @id_matricula
        FROM STRING_SPLIT(@asignaturas, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL
          AND EXISTS (
              SELECT 1
              FROM Asignatura a
              JOIN Aula au ON a.id_aula = au.id_aula
              WHERE a.codigo_interno_asignatura = TRY_CAST(value AS INT)
                AND au.id_sede = @id_sede
          );

        COMMIT TRANSACTION;
        SELECT @id_matricula AS id_matricula_creada;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @msg VARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al matricular: %s', 16, 1, @msg);
    END CATCH
END
GO

-- CRUD: NOTA FINAL
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotaFinal_Insertar
    @promedio_final            DECIMAL(5,2) = NULL,
    @estado_nota               VARCHAR(20),
    @id_estudiante             INT,
    @codigo_interno_asignatura INT,
    @id_periodo                INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @estado_nota NOT IN ('Aprobado', 'Reprobado', 'En curso')
    BEGIN
        RAISERROR('Error: Estado de nota no valido.', 16, 1);
        RETURN;
    END
    IF (@estado_nota = 'En curso' AND @promedio_final IS NOT NULL)
       OR (@estado_nota IN ('Aprobado', 'Reprobado') AND @promedio_final IS NULL)
    BEGIN
        RAISERROR('Error: En curso sin promedio; Aprobado/Reprobado con promedio obligatorio.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
       OR NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: Estudiante, asignatura o periodo no existe.', 16, 1);
        RETURN;
    END
    INSERT INTO NotaFinal (promedio_final, estado_nota, id_estudiante, codigo_interno_asignatura, id_periodo)
    VALUES (@promedio_final, @estado_nota, @id_estudiante, @codigo_interno_asignatura, @id_periodo);
    SELECT SCOPE_IDENTITY() AS id_nota_final_creada;
END
GO

-- CRUD: ASISTENCIA
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asistencia_Insertar
    @fecha_asistencia          DATETIME,
    @estado_asistencia         VARCHAR(15),
    @id_estudiante             INT,
    @codigo_interno_asignatura INT,
    @justificacion             VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @estado_asistencia NOT IN ('Presente', 'Ausente', 'Tardía', 'Justificada')
    BEGIN
        RAISERROR('Error: Estado de asistencia no valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
       OR NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: Estudiante o asignatura no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1
        FROM AsignaturaMatricula am
        JOIN Matricula m ON m.id_matricula = am.id_matricula
        WHERE m.id_estudiante = @id_estudiante
          AND am.codigo_interno_asignatura = @codigo_interno_asignatura
          AND m.estado_matricula = 'Activa'
    )
    BEGIN
        RAISERROR('Error: El estudiante no esta matriculado activamente en esa asignatura.', 16, 1);
        RETURN;
    END
    INSERT INTO Asistencia (fecha_asistencia, estado_asistencia, justificacion, id_estudiante, codigo_interno_asignatura)
    VALUES (@fecha_asistencia, @estado_asistencia, @justificacion, @id_estudiante, @codigo_interno_asignatura);
    SELECT SCOPE_IDENTITY() AS id_asistencia_creada;
END
GO

-- CRUD: TUTORIA
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Tutoria_Insertar
    @codigo_interno_profesor INT,
    @id_curso                INT,
    @antiguedad_tutor        INT = NULL,
    @fecha_inicio_tutoria    DATE = NULL,
    @fecha_fin_tutoria       DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
       OR NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: Profesor o curso no existe.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Tutoria WHERE id_curso = @id_curso AND fecha_fin_tutoria IS NULL)
    BEGIN
        RAISERROR('Error: El curso ya tiene un tutor activo.', 16, 1);
        RETURN;
    END
    INSERT INTO Tutoria (antiguedad_tutor, fecha_inicio_tutoria, fecha_fin_tutoria,
                         codigo_interno_profesor, id_curso)
    VALUES (@antiguedad_tutor, @fecha_inicio_tutoria, @fecha_fin_tutoria,
            @codigo_interno_profesor, @id_curso);
    SELECT SCOPE_IDENTITY() AS id_tutoria_creada;
END
GO

-- CRUD: USUARIO
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Usuario_Insertar
    @nombre_usuario          VARCHAR(20),
    @contrasena_plana        VARCHAR(100),
    @rol                     VARCHAR(25),
    @id_estudiante           INT = NULL,
    @codigo_interno_profesor INT = NULL
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
    INSERT INTO Usuario (nombre_usuario, contrasena_usuario, rol, activo, id_estudiante, codigo_interno_profesor)
    VALUES (@nombre_usuario,
            CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', @contrasena_plana), 2),
            @rol, 1, @id_estudiante, @codigo_interno_profesor);
    SELECT SCOPE_IDENTITY() AS id_usuario_creado;
END
GO

-- CONSULTAS CON JOINS
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Inner_ProfesorAsignatura
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS profesor, a.nombre_asignatura AS asignatura,
           a.antiguedad_profesor AS antiguedad_anios
    FROM Profesor p
    INNER JOIN Asignatura a ON p.codigo_interno_profesor = a.codigo_interno_profesor
    WHERE a.fecha_fin_imparticion_profe IS NULL
    ORDER BY p.nombre_profesor;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Left_AsignaturaPrerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura,
           pr.nombre_asignatura_prerequisito AS requiere_aprobar
    FROM Asignatura a
    LEFT JOIN AsignaturaPrerrequisito ap ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    LEFT JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Right_AsignaturaMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT am.id_matricula, a.nombre_asignatura AS asignatura
    FROM AsignaturaMatricula am
    RIGHT JOIN Asignatura a ON a.codigo_interno_asignatura = am.codigo_interno_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Full_EstudianteMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante AS estudiante, m.id_matricula, m.fecha_matricula, m.estado_matricula
    FROM Estudiante e
    FULL JOIN Matricula m ON e.id_estudiante = m.id_estudiante;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Cross_ProfesorAula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS profesor, a.nombre_aula AS aula
    FROM Profesor p
    CROSS JOIN Aula a;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Self_Prerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura,
           pr.nombre_asignatura_prerequisito AS asignatura_requerida
    FROM AsignaturaPrerrequisito ap
    JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_LeftExclusive_SinPrerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura
    FROM Asignatura a
    LEFT JOIN AsignaturaPrerrequisito ap ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    WHERE ap.id_asignatura_prerrequisito IS NULL
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_RightExclusive_SinMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante AS estudiante
    FROM Matricula m
    RIGHT JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE m.id_matricula IS NULL
    ORDER BY e.nombre_estudiante;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorBloque
    @dia_semana VARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: Dia o bloque no valido.', 16, 1);
        RETURN;
    END
    SELECT a.nombre_asignatura AS asignatura,
           p.nombre_profesor AS profesor,
           au.nombre_aula AS aula,
           h.dia_semana, h.num_bloque, h.hora_inicio_bloque, h.hora_fin_bloque
    FROM Horario h
    JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
    JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Profesor p ON a.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula au ON a.id_aula = au.id_aula
    WHERE h.dia_semana = @dia_semana AND h.num_bloque = @num_bloque
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ProfesorDeAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura no existe.', 16, 1);
        RETURN;
    END
    SELECT p.codigo_interno_profesor, p.nombre_profesor, p.apellido1_profesor,
           p.correo_profesor, p.telefono_profesor,
           a.fecha_inicio_imparticion_profe, a.antiguedad_profesor AS antiguedad_anios
    FROM Asignatura a
    JOIN Profesor p ON p.codigo_interno_profesor = a.codigo_interno_profesor
    WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
      AND a.fecha_fin_imparticion_profe IS NULL;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasConPrerrequisitos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.nombre_asignatura AS asignatura,
           COUNT(ap.id_asignatura_prerrequisito) AS cantidad_prerrequisitos,
           STRING_AGG(pr.nombre_asignatura_prerequisito, ', ') AS lista_prerrequisitos
    FROM Asignatura a
    JOIN AsignaturaPrerrequisito ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito
    WHERE pr.estado_prerrequisito = 'Activo'
    GROUP BY a.codigo_interno_asignatura, a.nombre_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AulasVacias
    @dia_semana VARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: Dia o bloque no valido.', 16, 1);
        RETURN;
    END
    SELECT au.numero_aula, s.nombre_sede, au.nombre_aula,
           au.capacidad, au.metros_cuadrados, au.tiene_proyector
    FROM Aula au
    JOIN Sede s ON au.id_sede = s.id_sede
    WHERE NOT EXISTS (
        SELECT 1
        FROM Horario h
        JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
        JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
        WHERE a.id_aula = au.id_aula
          AND h.dia_semana = @dia_semana
          AND h.num_bloque = @num_bloque
    )
    ORDER BY s.nombre_sede, au.numero_aula;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorCicloCurso
    @codigo_interno_ciclo INT,
    @id_curso INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ci.nombre_ciclo AS ciclo, cu.nivel_curso AS curso,
           a.codigo_interno_asignatura, a.codigo_oficial,
           a.nombre_asignatura AS asignatura, a.duracion_horas_asignatura,
           p.nombre_profesor AS profesor_titular
    FROM Asignatura a
    JOIN AsignaturaCurso ac ON ac.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Curso cu ON cu.id_curso = ac.id_curso
    JOIN Ciclo ci ON ci.codigo_interno_ciclo = cu.codigo_interno_ciclo
    LEFT JOIN Profesor p ON p.codigo_interno_profesor = a.codigo_interno_profesor
    WHERE ci.codigo_interno_ciclo = @codigo_interno_ciclo
      AND (@id_curso IS NULL OR cu.id_curso = @id_curso)
    ORDER BY cu.nivel_curso, a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioCompleto
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.dia_semana, h.num_bloque, h.hora_inicio_bloque, h.hora_fin_bloque,
           au.nombre_aula AS aula, p.nombre_profesor AS profesor,
           a.nombre_asignatura AS asignatura, cu.nivel_curso AS curso, ci.nombre_ciclo AS ciclo
    FROM Horario h
    JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
    JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Profesor p ON a.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula au ON a.id_aula = au.id_aula
    LEFT JOIN AsignaturaCurso ac ON ac.codigo_interno_asignatura = a.codigo_interno_asignatura
    LEFT JOIN Curso cu ON ac.id_curso = cu.id_curso
    LEFT JOIN Ciclo ci ON cu.codigo_interno_ciclo = ci.codigo_interno_ciclo
    ORDER BY h.dia_semana, h.num_bloque;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, s.nombre_sede AS sede_matricula, a.nombre_asignatura, m.fecha_matricula
    FROM AsignaturaMatricula am
    JOIN Matricula m ON am.id_matricula = m.id_matricula
    JOIN Sede s ON m.id_sede = s.id_sede
    JOIN Estudiante e ON m.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON am.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE m.id_estudiante = @id_estudiante AND m.estado_matricula = 'Activa'
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_TutoresPorCurso
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS tutor, cu.nivel_curso AS curso,
           ci.nombre_ciclo AS ciclo, t.antiguedad_tutor AS antiguedad_anios,
           t.fecha_inicio_tutoria
    FROM Tutoria t
    JOIN Profesor p ON t.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Curso cu ON t.id_curso = cu.id_curso
    JOIN Ciclo ci ON cu.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE t.fecha_fin_tutoria IS NULL
    ORDER BY ci.nombre_ciclo, cu.nivel_curso;
END
GO

USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ResumenAsistenciaEstudiante
    @id_estudiante INT,
    @fecha_desde DATETIME = NULL,
    @fecha_hasta DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, a.nombre_asignatura,
           COUNT(CASE WHEN asis.estado_asistencia = 'Presente' THEN 1 END) AS presentes,
           COUNT(CASE WHEN asis.estado_asistencia = 'Ausente' THEN 1 END) AS ausentes,
           COUNT(CASE WHEN asis.estado_asistencia = 'Tardía' THEN 1 END) AS tardias,
           COUNT(CASE WHEN asis.estado_asistencia = 'Justificada' THEN 1 END) AS justificadas,
           COUNT(*) AS total_clases
    FROM Asistencia asis
    JOIN Estudiante e ON asis.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON asis.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE asis.id_estudiante = @id_estudiante
      AND (@fecha_desde IS NULL OR asis.fecha_asistencia >= @fecha_desde)
      AND (@fecha_hasta IS NULL OR asis.fecha_asistencia <= @fecha_hasta)
    GROUP BY e.nombre_estudiante, a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
SELECT COUNT(*) AS total_procedimientos FROM sys.procedures;
GO
