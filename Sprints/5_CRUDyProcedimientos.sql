/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 5/7
   PROCEDIMIENTOS ALMACENADOS (CRUD)
   ============================================================================ */

-- CRUD: SEDE

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Insertar
    @nombre_sede    NVARCHAR(100),
    @direccion_sede NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Sede WHERE nombre_sede = @nombre_sede)
    BEGIN
        RAISERROR('Error: Ya existe una sede con el nombre "%s".', 16, 1, @nombre_sede);
        RETURN;
    END
    INSERT INTO Sede (nombre_sede, direccion_sede)
    VALUES (@nombre_sede, @direccion_sede);
    SELECT SCOPE_IDENTITY() AS id_sede_creado;
    RAISERROR('Sede insertada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Actualizar
    @id_sede        INT,
    @nombre_sede    NVARCHAR(100),
    @direccion_sede NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede con ID %d no existe.', 16, 1, @id_sede);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Sede WHERE nombre_sede = @nombre_sede AND id_sede != @id_sede)
    BEGIN
        RAISERROR('Error: Ya existe otra sede con el nombre "%s".', 16, 1, @nombre_sede);
        RETURN;
    END
    UPDATE Sede
       SET nombre_sede = @nombre_sede,
           direccion_sede = @direccion_sede
     WHERE id_sede = @id_sede;
    RAISERROR('Sede actualizada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Eliminar
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
    RAISERROR('Sede eliminada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_ObtenerPorId
    @id_sede INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_sede, nombre_sede, direccion_sede
    FROM Sede
    WHERE id_sede = @id_sede;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro la sede con ID %d.', 10, 1, @id_sede);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Sede_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_sede, nombre_sede, direccion_sede
    FROM Sede
    ORDER BY nombre_sede;
END
GO

-- ============================================================================
-- CRUD: CICLO
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Insertar
    @nombre_ciclo   NVARCHAR(100),
    @categoria      NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Ciclo WHERE nombre_ciclo = @nombre_ciclo)
    BEGIN
        RAISERROR('Error: Ya existe un ciclo con el nombre "%s".', 16, 1, @nombre_ciclo);
        RETURN;
    END
    IF @categoria NOT IN (N'Grado Medio', N'Grado Superior', N'Bachillerato Técnico')
    BEGIN
        RAISERROR('Error: La categoria "%s" no es valida. Debe ser: Grado Medio, Grado Superior o Bachillerato Tecnico.', 16, 1, @categoria);
        RETURN;
    END
    INSERT INTO Ciclo (nombre_ciclo, categoria)
    VALUES (@nombre_ciclo, @categoria);
    SELECT SCOPE_IDENTITY() AS codigo_interno_ciclo_creado;
    RAISERROR('Ciclo insertado correctamente.', 10, 1);
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
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Ciclo WHERE nombre_ciclo = @nombre_ciclo AND codigo_interno_ciclo != @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: Ya existe otro ciclo con el nombre "%s".', 16, 1, @nombre_ciclo);
        RETURN;
    END
    UPDATE Ciclo
       SET nombre_ciclo = @nombre_ciclo,
           categoria    = @categoria
     WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
    RAISERROR('Ciclo actualizado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Eliminar
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Curso WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: No se puede eliminar el ciclo porque tiene cursos asociados.', 16, 1);
        RETURN;
    END
    DELETE FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
    RAISERROR('Ciclo eliminado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_ObtenerPorId
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_ciclo, nombre_ciclo, categoria
    FROM Ciclo
    WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro el ciclo con ID %d.', 10, 1, @codigo_interno_ciclo);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Ciclo_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_ciclo, nombre_ciclo, categoria
    FROM Ciclo
    ORDER BY nombre_ciclo;
END
GO

-- ============================================================================
-- CRUD: CURSO
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Insertar
    @codigo_interno_ciclo INT,
    @nombre_curso         NVARCHAR(50),
    @nivel                INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Curso WHERE codigo_interno_ciclo = @codigo_interno_ciclo AND nivel = @nivel)
    BEGIN
        RAISERROR('Error: Ya existe el nivel %d para este ciclo.', 16, 1, @nivel);
        RETURN;
    END
    IF @nivel <= 0
    BEGIN
        RAISERROR('Error: El nivel debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    INSERT INTO Curso (codigo_interno_ciclo, nombre_curso, nivel)
    VALUES (@codigo_interno_ciclo, @nombre_curso, @nivel);
    SELECT SCOPE_IDENTITY() AS id_curso_creado;
    RAISERROR('Curso insertado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Actualizar
    @id_curso               INT,
    @codigo_interno_ciclo   INT,
    @nombre_curso           NVARCHAR(50),
    @nivel                  INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Curso WHERE codigo_interno_ciclo = @codigo_interno_ciclo AND nivel = @nivel AND id_curso != @id_curso)
    BEGIN
        RAISERROR('Error: Ya existe el nivel %d para este ciclo.', 16, 1, @nivel);
        RETURN;
    END
    UPDATE Curso
       SET codigo_interno_ciclo = @codigo_interno_ciclo,
           nombre_curso         = @nombre_curso,
           nivel                = @nivel
     WHERE id_curso = @id_curso;
    RAISERROR('Curso actualizado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Eliminar
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Asignatura WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: No se puede eliminar el curso porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Curso WHERE id_curso = @id_curso;
    RAISERROR('Curso eliminado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_ObtenerPorId
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_curso, codigo_interno_ciclo, nombre_curso, nivel
    FROM Curso
    WHERE id_curso = @id_curso;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro el curso con ID %d.', 10, 1, @id_curso);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.id_curso, c.codigo_interno_ciclo, ci.nombre_ciclo, c.nombre_curso, c.nivel
    FROM Curso c
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    ORDER BY ci.nombre_ciclo, c.nivel;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Curso_ListarPorCiclo
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_curso, codigo_interno_ciclo, nombre_curso, nivel
    FROM Curso
    WHERE codigo_interno_ciclo = @codigo_interno_ciclo
    ORDER BY nivel;
END
GO

-- ============================================================================
-- CRUD: ASIGNATURA
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Insertar
    @codigo_oficial       VARCHAR(20),
    @nombre_asignatura    NVARCHAR(100),
    @duracion_horas       INT,
    @id_curso             INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Asignatura WHERE codigo_oficial = @codigo_oficial)
    BEGIN
        RAISERROR('Error: Ya existe una asignatura con el codigo oficial "%s".', 16, 1, @codigo_oficial);
        RETURN;
    END
    IF @duracion_horas <= 0
    BEGIN
        RAISERROR('Error: La duracion en horas debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas, id_curso)
    VALUES (@codigo_oficial, @nombre_asignatura, @duracion_horas, @id_curso);
    SELECT SCOPE_IDENTITY() AS codigo_interno_asignatura_creado;
    RAISERROR('Asignatura insertada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Actualizar
    @codigo_interno_asignatura INT,
    @codigo_oficial            VARCHAR(20),
    @nombre_asignatura         NVARCHAR(100),
    @duracion_horas            INT,
    @id_curso                  INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Asignatura WHERE codigo_oficial = @codigo_oficial AND codigo_interno_asignatura != @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: Ya existe otra asignatura con el codigo oficial "%s".', 16, 1, @codigo_oficial);
        RETURN;
    END
    UPDATE Asignatura
       SET codigo_oficial     = @codigo_oficial,
           nombre_asignatura  = @nombre_asignatura,
           duracion_horas     = @duracion_horas,
           id_curso           = @id_curso
     WHERE codigo_interno_asignatura = @codigo_interno_asignatura;
    RAISERROR('Asignatura actualizada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Eliminar
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Prerrequisito WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: No se puede eliminar la asignatura porque es requisito de otra.', 16, 1);
        RETURN;
    END
    DELETE FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura;
    RAISERROR('Asignatura eliminada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_ObtenerPorId
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.codigo_oficial, a.nombre_asignatura, 
           a.duracion_horas, a.id_curso, c.nombre_curso, ci.nombre_ciclo
    FROM Asignatura a
    JOIN Curso c ON a.id_curso = c.id_curso
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro la asignatura con ID %d.', 10, 1, @codigo_interno_asignatura);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.codigo_oficial, a.nombre_asignatura, 
           a.duracion_horas, a.id_curso, c.nombre_curso
    FROM Asignatura a
    JOIN Curso c ON a.id_curso = c.id_curso
    ORDER BY a.nombre_asignatura;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Asignatura_ListarPorCurso
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_asignatura, codigo_oficial, nombre_asignatura, duracion_horas
    FROM Asignatura
    WHERE id_curso = @id_curso
    ORDER BY nombre_asignatura;
END
GO

-- ============================================================================
-- CRUD: PROFESOR
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Insertar
    @cedula_profesor        VARCHAR(20),
    @nombre_profesor        NVARCHAR(100),
    @correo_profesor        VARCHAR(100) = NULL,
    @telefono_profesor      VARCHAR(20) = NULL,
    @seguro_social          VARCHAR(50) = NULL,
    @direccion_profesor     NVARCHAR(200) = NULL,
    @fecha_inicio_contrato  DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @fecha_inicio_contrato IS NULL
        SET @fecha_inicio_contrato = GETDATE();
    
    IF EXISTS (SELECT 1 FROM Profesor WHERE cedula_profesor = @cedula_profesor)
    BEGIN
        RAISERROR('Error: Ya existe un profesor con la cedula "%s".', 16, 1, @cedula_profesor);
        RETURN;
    END
    IF @correo_profesor IS NOT NULL AND EXISTS (SELECT 1 FROM Profesor WHERE correo_profesor = @correo_profesor)
    BEGIN
        RAISERROR('Error: Ya existe un profesor con el correo "%s".', 16, 1, @correo_profesor);
        RETURN;
    END
    INSERT INTO Profesor (cedula_profesor, nombre_profesor, correo_profesor, 
                          telefono_profesor, seguro_social, direccion_profesor, fecha_inicio_contrato)
    VALUES (@cedula_profesor, @nombre_profesor, @correo_profesor, 
            @telefono_profesor, @seguro_social, @direccion_profesor, @fecha_inicio_contrato);
    SELECT SCOPE_IDENTITY() AS codigo_interno_profesor_creado;
    RAISERROR('Profesor insertado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Actualizar
    @codigo_interno_profesor INT,
    @nombre_profesor         NVARCHAR(100),
    @correo_profesor         VARCHAR(100) = NULL,
    @telefono_profesor       VARCHAR(20) = NULL,
    @direccion_profesor      NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    IF @correo_profesor IS NOT NULL AND EXISTS (SELECT 1 FROM Profesor WHERE correo_profesor = @correo_profesor AND codigo_interno_profesor != @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: Ya existe otro profesor con el correo "%s".', 16, 1, @correo_profesor);
        RETURN;
    END
    UPDATE Profesor
       SET nombre_profesor    = @nombre_profesor,
           correo_profesor    = @correo_profesor,
           telefono_profesor  = @telefono_profesor,
           direccion_profesor = @direccion_profesor
     WHERE codigo_interno_profesor = @codigo_interno_profesor;
    RAISERROR('Profesor actualizado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Eliminar
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM ProfesorAsignatura WHERE codigo_interno_profesor = @codigo_interno_profesor AND fecha_fin IS NULL)
    BEGIN
        RAISERROR('Error: No se puede eliminar el profesor porque tiene asignaturas activas.', 16, 1);
        RETURN;
    END
    UPDATE Profesor SET fecha_fin_contrato = GETDATE() 
    WHERE codigo_interno_profesor = @codigo_interno_profesor;
    RAISERROR('Profesor marcado como inactivo correctamente (fecha_fin_contrato = hoy).', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_ObtenerPorId
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_profesor, cedula_profesor, nombre_profesor, 
           correo_profesor, telefono_profesor, seguro_social, direccion_profesor,
           fecha_inicio_contrato, fecha_fin_contrato
    FROM Profesor
    WHERE codigo_interno_profesor = @codigo_interno_profesor;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro el profesor con ID %d.', 10, 1, @codigo_interno_profesor);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_profesor, cedula_profesor, nombre_profesor, 
           correo_profesor, telefono_profesor, direccion_profesor,
           fecha_inicio_contrato, fecha_fin_contrato
    FROM Profesor
    ORDER BY nombre_profesor;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Profesor_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT codigo_interno_profesor, cedula_profesor, nombre_profesor, 
           correo_profesor, telefono_profesor, direccion_profesor,
           fecha_inicio_contrato
    FROM Profesor
    WHERE fecha_fin_contrato IS NULL
    ORDER BY nombre_profesor;
END
GO

-- ============================================================================
-- CRUD: AULA
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_Insertar
    @numero_aula        INT,
    @id_sede            INT,
    @nombre_aula        NVARCHAR(100),
    @capacidad          INT,
    @metros_cuadrados   DECIMAL(6,2) = NULL,
    @tiene_proyector    BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede con ID %d no existe.', 16, 1, @id_sede);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Aula WHERE id_sede = @id_sede AND nombre_aula = @nombre_aula)
    BEGIN
        RAISERROR('Error: Ya existe un aula con el nombre "%s" en esta sede.', 16, 1, @nombre_aula);
        RETURN;
    END
    IF @capacidad <= 0
    BEGIN
        RAISERROR('Error: La capacidad debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    INSERT INTO Aula (numero_aula, id_sede, nombre_aula, capacidad, metros_cuadrados, tiene_proyector)
    VALUES (@numero_aula, @id_sede, @nombre_aula, @capacidad, @metros_cuadrados, @tiene_proyector);
    RAISERROR('Aula insertada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_Actualizar
    @numero_aula        INT,
    @nombre_aula        NVARCHAR(100),
    @capacidad          INT,
    @metros_cuadrados   DECIMAL(6,2) = NULL,
    @tiene_proyector    BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE numero_aula = @numero_aula)
    BEGIN
        RAISERROR('Error: El aula con numero %d no existe.', 16, 1, @numero_aula);
        RETURN;
    END
    UPDATE Aula
       SET nombre_aula      = @nombre_aula,
           capacidad        = @capacidad,
           metros_cuadrados = @metros_cuadrados,
           tiene_proyector  = @tiene_proyector
     WHERE numero_aula = @numero_aula;
    RAISERROR('Aula actualizada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_Eliminar
    @numero_aula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE numero_aula = @numero_aula)
    BEGIN
        RAISERROR('Error: El aula con numero %d no existe.', 16, 1, @numero_aula);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Horario WHERE numero_aula = @numero_aula)
    BEGIN
        RAISERROR('Error: No se puede eliminar el aula porque tiene horarios asociados.', 16, 1);
        RETURN;
    END
    DELETE FROM Aula WHERE numero_aula = @numero_aula;
    RAISERROR('Aula eliminada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_ObtenerPorId
    @numero_aula INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.numero_aula, a.id_sede, s.nombre_sede, a.nombre_aula, 
           a.capacidad, a.metros_cuadrados, a.tiene_proyector
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    WHERE a.numero_aula = @numero_aula;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro el aula con numero %d.', 10, 1, @numero_aula);
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

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Aula_ListarPorSede
    @id_sede INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT numero_aula, nombre_aula, capacidad, metros_cuadrados, tiene_proyector
    FROM Aula
    WHERE id_sede = @id_sede
    ORDER BY numero_aula;
END
GO

-- ============================================================================
-- CRUD: ESTUDIANTE
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Insertar
    @cedula_estudiante    VARCHAR(20),
    @nombre_estudiante    NVARCHAR(100),
    @correo_estudiante    VARCHAR(100) = NULL,
    @telefono_estudiante  VARCHAR(20) = NULL,
    @fecha_nacimiento     DATE = NULL,
    @fecha_ingreso        DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @fecha_ingreso IS NULL
        SET @fecha_ingreso = GETDATE();
    
    IF EXISTS (SELECT 1 FROM Estudiante WHERE cedula_estudiante = @cedula_estudiante)
    BEGIN
        RAISERROR('Error: Ya existe un estudiante con la cedula "%s".', 16, 1, @cedula_estudiante);
        RETURN;
    END
    IF @correo_estudiante IS NOT NULL AND EXISTS (SELECT 1 FROM Estudiante WHERE correo_estudiante = @correo_estudiante)
    BEGIN
        RAISERROR('Error: Ya existe un estudiante con el correo "%s".', 16, 1, @correo_estudiante);
        RETURN;
    END
    INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, correo_estudiante, 
                            telefono_estudiante, fecha_nacimiento, fecha_ingreso)
    VALUES (@cedula_estudiante, @nombre_estudiante, @correo_estudiante, 
            @telefono_estudiante, @fecha_nacimiento, @fecha_ingreso);
    SELECT SCOPE_IDENTITY() AS id_estudiante_creado;
    RAISERROR('Estudiante insertado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Actualizar
    @id_estudiante        INT,
    @nombre_estudiante    NVARCHAR(100),
    @correo_estudiante    VARCHAR(100) = NULL,
    @telefono_estudiante  VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante con ID %d no existe.', 16, 1, @id_estudiante);
        RETURN;
    END
    IF @correo_estudiante IS NOT NULL AND EXISTS (SELECT 1 FROM Estudiante WHERE correo_estudiante = @correo_estudiante AND id_estudiante != @id_estudiante)
    BEGIN
        RAISERROR('Error: Ya existe otro estudiante con el correo "%s".', 16, 1, @correo_estudiante);
        RETURN;
    END
    UPDATE Estudiante
       SET nombre_estudiante    = @nombre_estudiante,
           correo_estudiante    = @correo_estudiante,
           telefono_estudiante  = @telefono_estudiante
     WHERE id_estudiante = @id_estudiante;
    RAISERROR('Estudiante actualizado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Eliminar
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante con ID %d no existe.', 16, 1, @id_estudiante);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Matricula WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: No se puede eliminar el estudiante porque tiene matriculas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Estudiante WHERE id_estudiante = @id_estudiante;
    RAISERROR('Estudiante eliminado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_ObtenerPorId
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_estudiante, cedula_estudiante, nombre_estudiante, 
           correo_estudiante, telefono_estudiante, fecha_nacimiento, fecha_ingreso
    FROM Estudiante
    WHERE id_estudiante = @id_estudiante;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontro el estudiante con ID %d.', 10, 1, @id_estudiante);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Estudiante_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT id_estudiante, cedula_estudiante, nombre_estudiante, 
           correo_estudiante, telefono_estudiante, fecha_nacimiento, fecha_ingreso
    FROM Estudiante
    ORDER BY nombre_estudiante;
END
GO

-- ============================================================================
-- CRUD: PROFESORASIGNATURA
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorAsignatura_Insertar
    @codigo_interno_profesor   INT,
    @codigo_interno_asignatura INT,
    @fecha_inicio              DATE,
    @fecha_fin                 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END
    IF @fecha_fin IS NOT NULL AND @fecha_fin < @fecha_inicio
    BEGIN
        RAISERROR('Error: La fecha de fin no puede ser anterior a la fecha de inicio.', 16, 1);
        RETURN;
    END
    INSERT INTO ProfesorAsignatura (codigo_interno_profesor, codigo_interno_asignatura, fecha_inicio, fecha_fin)
    VALUES (@codigo_interno_profesor, @codigo_interno_asignatura, @fecha_inicio, @fecha_fin);
    SELECT SCOPE_IDENTITY() AS id_profesor_asignatura_creado;
    RAISERROR('Relacion profesor-asignatura insertada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorAsignatura_Actualizar
    @id_profesor_asignatura   INT,
    @fecha_fin                DATE
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM ProfesorAsignatura WHERE id_profesor_asignatura = @id_profesor_asignatura)
    BEGIN
        RAISERROR('Error: La relacion con ID %d no existe.', 16, 1, @id_profesor_asignatura);
        RETURN;
    END
    UPDATE ProfesorAsignatura
       SET fecha_fin = @fecha_fin
     WHERE id_profesor_asignatura = @id_profesor_asignatura;
    RAISERROR('Relacion profesor-asignatura actualizada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorAsignatura_ListarPorProfesor
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT pa.id_profesor_asignatura, a.codigo_interno_asignatura, a.nombre_asignatura,
           pa.fecha_inicio, pa.fecha_fin, pa.antiguedad_asignatura
    FROM ProfesorAsignatura pa
    JOIN Asignatura a ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE pa.codigo_interno_profesor = @codigo_interno_profesor
    ORDER BY pa.fecha_inicio DESC;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorAsignatura_ListarActivos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor, a.nombre_asignatura, pa.fecha_inicio, pa.antiguedad_asignatura
    FROM ProfesorAsignatura pa
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Asignatura a ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE pa.fecha_fin IS NULL
    ORDER BY p.nombre_profesor;
END
GO

-- ============================================================================
-- CRUD: TUTORIA
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Tutoria_Insertar
    @codigo_interno_profesor INT,
    @id_curso                INT,
    @antiguedad_tutor        INT = 0,
    @fecha_inicio_tutoria    DATE = NULL,
    @fecha_fin_tutoria       DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Tutoria WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso ya tiene un tutor asignado.', 16, 1);
        RETURN;
    END
    IF @fecha_fin_tutoria IS NOT NULL AND @fecha_inicio_tutoria IS NOT NULL AND @fecha_fin_tutoria < @fecha_inicio_tutoria
    BEGIN
        RAISERROR('Error: La fecha de fin no puede ser anterior a la fecha de inicio.', 16, 1);
        RETURN;
    END
    INSERT INTO Tutoria (codigo_interno_profesor, id_curso, antiguedad_tutor, fecha_inicio_tutoria, fecha_fin_tutoria)
    VALUES (@codigo_interno_profesor, @id_curso, @antiguedad_tutor, @fecha_inicio_tutoria, @fecha_fin_tutoria);
    SELECT SCOPE_IDENTITY() AS id_tutoria_creado;
    RAISERROR('Tutoria asignada correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Tutoria_Listar
AS
BEGIN
    SET NOCOUNT ON;
    SELECT t.id_tutoria, p.nombre_profesor, c.nombre_curso, t.antiguedad_tutor,
           t.fecha_inicio_tutoria, t.fecha_fin_tutoria
    FROM Tutoria t
    JOIN Profesor p ON t.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Curso c ON t.id_curso = c.id_curso;
END
GO

-- ============================================================================
-- CRUD: HORARIO
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_Insertar
    @id_profesor_asignatura INT,
    @numero_aula            INT,
    @id_curso               INT,
    @dia_semana             NVARCHAR(15),
    @bloque                 INT,
    @anio_academico         INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM ProfesorAsignatura WHERE id_profesor_asignatura = @id_profesor_asignatura)
    BEGIN
        RAISERROR('Error: La relacion profesor-asignatura con ID %d no existe.', 16, 1, @id_profesor_asignatura);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE numero_aula = @numero_aula)
    BEGIN
        RAISERROR('Error: El aula con numero %d no existe.', 16, 1, @numero_aula);
        RETURN;
    END
    IF @bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: El bloque debe estar entre 1 y 6.', 16, 1);
        RETURN;
    END
    IF @dia_semana NOT IN (N'Lunes', N'Martes', N'Miércoles', N'Jueves', N'Viernes', N'Sábado')
    BEGIN
        RAISERROR('Error: Dia no valido. Debe ser de Lunes a Sabado.', 16, 1);
        RETURN;
    END
    INSERT INTO Horario (id_profesor_asignatura, numero_aula, id_curso, dia_semana, bloque, anio_academico)
    VALUES (@id_profesor_asignatura, @numero_aula, @id_curso, @dia_semana, @bloque, @anio_academico);
    SELECT SCOPE_IDENTITY() AS id_horario_creado;
    RAISERROR('Horario insertado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_Eliminar
    @id_horario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Horario WHERE id_horario = @id_horario)
    BEGIN
        RAISERROR('Error: El horario con ID %d no existe.', 16, 1, @id_horario);
        RETURN;
    END
    DELETE FROM Horario WHERE id_horario = @id_horario;
    RAISERROR('Horario eliminado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_ListarPorProfesor
    @codigo_interno_profesor INT,
    @anio_academico          INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.id_horario, h.dia_semana, h.bloque, a.nombre_aula, 
           asig.nombre_asignatura, c.nombre_curso, h.anio_academico
    FROM Horario h
    JOIN ProfesorAsignatura pa ON h.id_profesor_asignatura = pa.id_profesor_asignatura
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula a ON h.numero_aula = a.numero_aula
    JOIN Asignatura asig ON pa.codigo_interno_asignatura = asig.codigo_interno_asignatura
    JOIN Curso c ON h.id_curso = c.id_curso
    WHERE p.codigo_interno_profesor = @codigo_interno_profesor
      AND (@anio_academico IS NULL OR h.anio_academico = @anio_academico)
    ORDER BY h.dia_semana, h.bloque;
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_ListarPorAula
    @numero_aula     INT,
    @anio_academico  INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT h.id_horario, h.dia_semana, h.bloque, p.nombre_profesor, 
           asig.nombre_asignatura, c.nombre_curso, h.anio_academico
    FROM Horario h
    JOIN ProfesorAsignatura pa ON h.id_profesor_asignatura = pa.id_profesor_asignatura
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Asignatura asig ON pa.codigo_interno_asignatura = asig.codigo_interno_asignatura
    JOIN Curso c ON h.id_curso = c.id_curso
    WHERE h.numero_aula = @numero_aula
      AND (@anio_academico IS NULL OR h.anio_academico = @anio_academico)
    ORDER BY h.dia_semana, h.bloque;
END
GO

-- ============================================================================
-- CRUD: PRERREQUISITO
-- ============================================================================

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Prerrequisito_Insertar
    @codigo_interno_asignatura           INT,
    @codigo_interno_asignatura_requerida INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @codigo_interno_asignatura = @codigo_interno_asignatura_requerida
    BEGIN
        RAISERROR('Error: Una asignatura no puede ser requisito de si misma.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Prerrequisito WHERE codigo_interno_asignatura = @codigo_interno_asignatura 
              AND codigo_interno_asignatura_requerida = @codigo_interno_asignatura_requerida)
    BEGIN
        RAISERROR('Error: Esta relacion de prerrequisito ya existe.', 16, 1);
        RETURN;
    END
    INSERT INTO Prerrequisito (codigo_interno_asignatura, codigo_interno_asignatura_requerida, estado)
    VALUES (@codigo_interno_asignatura, @codigo_interno_asignatura_requerida, N'Activo');
    SELECT SCOPE_IDENTITY() AS id_prerrequisito_creado;
    RAISERROR('Prerrequisito insertado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Prerrequisito_Desactivar
    @id_prerrequisito INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: El prerrequisito con ID %d no existe.', 16, 1, @id_prerrequisito);
        RETURN;
    END
    UPDATE Prerrequisito SET estado = N'Inactivo' WHERE id_prerrequisito = @id_prerrequisito;
    RAISERROR('Prerrequisito desactivado correctamente.', 10, 1);
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Prerrequisito_ListarPorAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.id_prerrequisito, a.codigo_interno_asignatura, a.nombre_asignatura, p.estado
    FROM Prerrequisito p
    JOIN Asignatura a ON p.codigo_interno_asignatura_requerida = a.codigo_interno_asignatura
    WHERE p.codigo_interno_asignatura = @codigo_interno_asignatura AND p.estado = N'Activo';
END
GO


-- PROCEDIMIENTO TRANSACCIONAL: matricular estudiante con varias asignaturas
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_MatricularEstudiante
    @id_estudiante INT,
    @periodo       NVARCHAR(50),
    @asignaturas   VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @id_matricula INT;
        
        IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
        BEGIN
            RAISERROR('Error: El estudiante con ID %d no existe.', 16, 1, @id_estudiante);
            RETURN;
        END
        
        INSERT INTO Matricula (id_estudiante, periodo, estado)
        VALUES (@id_estudiante, @periodo, N'Activa');
        SET @id_matricula = SCOPE_IDENTITY();
        
        INSERT INTO DetalleMatricula (id_matricula, codigo_interno_asignatura)
        SELECT @id_matricula, TRY_CAST(value AS INT)
        FROM STRING_SPLIT(@asignaturas, ',')
        WHERE TRY_CAST(value AS INT) IS NOT NULL;
        
        COMMIT TRANSACTION;
        SELECT @id_matricula AS id_matricula_creada;
        RAISERROR('Estudiante matriculado correctamente con %d asignatura(s).', 10, 1, @@ROWCOUNT);
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        RAISERROR('Error al matricular: %s', 16, 1, ERROR_MESSAGE());
    END CATCH
END
GO

-- PROCEDIMIENTO: Consultar horario de un profesor
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Horario_Profesor
    @codigo_interno_profesor INT,
    @anio_academico          INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor, asig.nombre_asignatura, c.nombre_curso,
           a.nombre_aula, h.dia_semana, h.bloque, h.anio_academico
    FROM Horario h
    JOIN ProfesorAsignatura pa ON h.id_profesor_asignatura = pa.id_profesor_asignatura
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Asignatura asig ON pa.codigo_interno_asignatura = asig.codigo_interno_asignatura
    JOIN Curso c ON h.id_curso = c.id_curso
    JOIN Aula a ON h.numero_aula = a.numero_aula
    WHERE p.codigo_interno_profesor = @codigo_interno_profesor
      AND (@anio_academico IS NULL OR h.anio_academico = @anio_academico)
    ORDER BY h.dia_semana, h.bloque;
    IF @@ROWCOUNT = 0
        RAISERROR('Advertencia: No se encontraron horarios para el profesor.', 10, 1);
END
GO

-- PROCEDIMIENTO: Consultar aulas disponibles
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AulasDisponibles
    @dia_semana     NVARCHAR(15),
    @bloque         INT,
    @anio_academico INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.numero_aula, s.nombre_sede, a.nombre_aula, a.capacidad
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    WHERE NOT EXISTS (
        SELECT 1 FROM Horario h
        WHERE h.numero_aula = a.numero_aula
          AND h.dia_semana = @dia_semana
          AND h.bloque = @bloque
          AND h.anio_academico = @anio_academico
    )
    ORDER BY s.nombre_sede, a.numero_aula;
END
GO

-- VERIFICACION FINAL
USE InstitutoTECNIC;
GO
SELECT COUNT(*) AS total_procedimientos FROM sys.procedures;
GO