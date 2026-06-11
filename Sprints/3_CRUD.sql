/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 3/11   
   PROCEDIMIENTOS ALMACENADOS DE CRUD
   ============================================================================ */
-- PROCEDIMIENTOS CRUD

-- CRUD: SEDE
--Crear una sede
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

--Actualizar una sede
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

--Eliminar una sede
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
    IF EXISTS (SELECT 1 FROM Matricula WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: No se puede eliminar la sede porque tiene matriculas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Sede WHERE id_sede = @id_sede;
END
GO

--Obtener una sede
--Obtener una sede
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Sede_Obtener
    @id_sede INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Sede WHERE id_sede = @id_sede)
    BEGIN
        RAISERROR('Error: La sede con ID %d no existe.', 16, 1, @id_sede);
        RETURN;
    END
    SELECT id_sede, nombre_sede, direccion_sede FROM Sede WHERE id_sede = @id_sede;
END
GO

-- CRUD: CICLO
--Crear un ciclo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Insertar
    @nombre_ciclo VARCHAR(100),
    @categoria    VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    IF @categoria NOT IN ('Grado Medio', 'Grado Superior', 'Bachillerato Tecnico')
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

--Actualizar un ciclo
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
    IF @categoria NOT IN ('Grado Medio', 'Grado Superior', 'Bachillerato Tecnico')
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

--Eliminar un ciclo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Eliminar
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
    IF EXISTS (SELECT 1 FROM AsignaturaCiclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: No se puede eliminar el ciclo porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
END
GO

--Obtener un ciclo
--Obtener un ciclo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Ciclo_Obtener
    @codigo_interno_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo con ID %d no existe.', 16, 1, @codigo_interno_ciclo);
        RETURN;
    END
    SELECT codigo_interno_ciclo, nombre_ciclo, categoria FROM Ciclo
    WHERE codigo_interno_ciclo = @codigo_interno_ciclo;
END
GO

-- CRUD: CURSO
--Crear un curso
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

--Actualizar un curso
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

--Eliminar un curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Curso_Eliminar
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM AsignaturaCurso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: No se puede eliminar el curso porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Tutoria WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: No se puede eliminar el curso porque tiene una tutoria asociada.', 16, 1);
        RETURN;
    END
    DELETE FROM Curso WHERE id_curso = @id_curso;
END
GO

--Obtener un curso
--Obtener un curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Curso_Obtener
    @id_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: El curso con ID %d no existe.', 16, 1, @id_curso);
        RETURN;
    END
    SELECT c.id_curso, c.nivel_curso, c.codigo_interno_ciclo, ci.nombre_ciclo
    FROM Curso c
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE c.id_curso = @id_curso;
END
GO

-- CRUD: PROFESOR
--Crear un profesor
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Profesor_Insertar
    @cedula_profesor        VARCHAR(20),
    @nombre_profesor        VARCHAR(50),
    @apellido1_profesor     VARCHAR(50),
    @apellido2_profesor     VARCHAR(50) = NULL,
    @telefono_profesor      VARCHAR(20) = NULL,
    @seguro_social_profesor INT = NULL,
    @direccion_profesor     VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Profesor WHERE cedula_profesor = @cedula_profesor)
    BEGIN
        RAISERROR('Error: Ya existe un profesor con esa cedula.', 16, 1);
        RETURN;
    END
    IF @cedula_profesor NOT LIKE '[1-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
       AND @cedula_profesor NOT LIKE '[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]'
    BEGIN
        RAISERROR('Error: Formato de cedula no valido (CR: 1-2345-6789 o pasaporte internacional).', 16, 1);
        RETURN;
    END
    IF @seguro_social_profesor IS NOT NULL AND EXISTS (
        SELECT 1 FROM Profesor WHERE seguro_social_profesor = @seguro_social_profesor
    )
    BEGIN
        RAISERROR('Error: Ya existe un profesor con ese numero de seguro social.', 16, 1);
        RETURN;
    END
    INSERT INTO Profesor (cedula_profesor, nombre_profesor, apellido1_profesor,
                          apellido2_profesor, telefono_profesor,
                          seguro_social_profesor, direccion_profesor)
    VALUES (@cedula_profesor, @nombre_profesor, @apellido1_profesor,
            @apellido2_profesor, @telefono_profesor,
            @seguro_social_profesor, @direccion_profesor);
    SELECT SCOPE_IDENTITY() AS codigo_interno_profesor_creado;
END
GO

--Actualizar un profesor
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Profesor_Actualizar
    @codigo_interno_profesor INT,
    @nombre_profesor        VARCHAR(50) = NULL,
    @apellido1_profesor     VARCHAR(50) = NULL,
    @apellido2_profesor     VARCHAR(50) = NULL,
    @telefono_profesor      VARCHAR(20) = NULL,
    @direccion_profesor     VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    UPDATE Profesor
       SET nombre_profesor    = COALESCE(@nombre_profesor, nombre_profesor),
           apellido1_profesor = COALESCE(@apellido1_profesor, apellido1_profesor),
           apellido2_profesor = COALESCE(@apellido2_profesor, apellido2_profesor),
           telefono_profesor  = COALESCE(@telefono_profesor, telefono_profesor),
           direccion_profesor = COALESCE(@direccion_profesor, direccion_profesor)
     WHERE codigo_interno_profesor = @codigo_interno_profesor;
END
GO

--Eliminar un profesor
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Profesor_Eliminar
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM AsignaturaProfesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: No se puede eliminar el profesor porque tiene asignaturas asignadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Tutoria WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: No se puede eliminar el profesor porque tiene tutorias asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor;
END
GO

--Obtener un profesor
--Obtener un profesor
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Profesor_Obtener
    @codigo_interno_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor con ID %d no existe.', 16, 1, @codigo_interno_profesor);
        RETURN;
    END
    SELECT p.codigo_interno_profesor, p.cedula_profesor, p.nombre_profesor,
           p.apellido1_profesor, p.apellido2_profesor, u.correo_usuario,
           p.telefono_profesor, p.seguro_social_profesor, p.direccion_profesor, p.id_usuario
    FROM Profesor p
    LEFT JOIN Usuario u ON p.id_usuario = u.id_usuario
    WHERE p.codigo_interno_profesor = @codigo_interno_profesor;
END
GO

-- CRUD: AULA
--Crear una aula
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

--Actualizar un aula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Aula_Actualizar
    @id_aula            INT,
    @numero_aula        INT,
    @nombre_aula        VARCHAR(100),
    @capacidad          INT,
    @metros_cuadrados   DECIMAL(8,2),
    @tiene_proyector    BIT,
    @id_sede            INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula con ID %d no existe.', 16, 1, @id_aula);
        RETURN;
    END
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
    UPDATE Aula
       SET numero_aula = @numero_aula, nombre_aula = @nombre_aula, capacidad = @capacidad,
           metros_cuadrados = @metros_cuadrados, tiene_proyector = @tiene_proyector, id_sede = @id_sede
     WHERE id_aula = @id_aula;
END
GO

--Eliminar un aula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Aula_Eliminar
    @id_aula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula con ID %d no existe.', 16, 1, @id_aula);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Asignatura WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: No se puede eliminar el aula porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Aula WHERE id_aula = @id_aula;
END
GO

--Obtener una aula
--Obtener un aula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Aula_Obtener
    @id_aula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula con ID %d no existe.', 16, 1, @id_aula);
        RETURN;
    END
    SELECT a.id_aula, a.numero_aula, s.nombre_sede, a.nombre_aula, a.capacidad,
           a.metros_cuadrados, a.tiene_proyector, a.id_sede
    FROM Aula a
    JOIN Sede s ON a.id_sede = s.id_sede
    WHERE a.id_aula = @id_aula;
END
GO

-- CRUD: ASIGNATURA

--Consultar meses de imparticion
USE InstitutoTECNIC;
GO
CREATE FUNCTION dbo.fn_MesesImparticion
(
    @fecha_inicio DATE,
    @fecha_fin    DATE,
    @fecha_corte  DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @meses INT;

    IF @fecha_inicio IS NULL OR @fecha_corte < @fecha_inicio
        RETURN 0;

    IF @fecha_fin IS NOT NULL AND @fecha_fin <= @fecha_corte
        RETURN 6;

    SET @meses = DATEDIFF(MONTH, @fecha_inicio, DATEADD(DAY, 1, @fecha_corte));

    IF @meses > 6
        SET @meses = 6;

    IF @meses < 0
        SET @meses = 0;

    RETURN @meses;
END
GO

--Consultar dias de imparticion activa
USE InstitutoTECNIC;
GO
CREATE FUNCTION dbo.fn_DiasImparticionActiva
(
    @fecha_inicio DATE,
    @fecha_fin    DATE,
    @fecha_corte  DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @meses INT;
    DECLARE @dias  INT;

    IF @fecha_inicio IS NULL OR @fecha_fin IS NOT NULL OR @fecha_corte < @fecha_inicio
        RETURN 0;

    SET @meses = DATEDIFF(MONTH, @fecha_inicio, DATEADD(DAY, 1, @fecha_corte));

    IF @meses > 6
        SET @meses = 6;

    SET @dias = DATEDIFF(DAY, DATEADD(MONTH, @meses, @fecha_inicio), @fecha_corte);

    IF @dias < 0
        SET @dias = 0;

    RETURN @dias;
END
GO

--Consultar horas de imparticion activa
USE InstitutoTECNIC;
GO
CREATE FUNCTION dbo.fn_HorasImparticionActiva
(
    @fecha_inicio DATE,
    @fecha_fin    DATE,
    @fecha_corte  DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @meses INT;
    DECLARE @dias  INT;
    DECLARE @horas INT;

    IF @fecha_inicio IS NULL OR @fecha_fin IS NOT NULL OR @fecha_corte < @fecha_inicio
        RETURN 0;

    SET @meses = DATEDIFF(MONTH, @fecha_inicio, DATEADD(DAY, 1, CAST(@fecha_corte AS DATE)));

    IF @meses > 6
        SET @meses = 6;

    SET @dias = DATEDIFF(DAY, DATEADD(MONTH, @meses, @fecha_inicio), CAST(@fecha_corte AS DATE));

    IF @dias < 0
        SET @dias = 0;

    SET @horas = DATEDIFF(HOUR, DATEADD(DAY, @dias, DATEADD(MONTH, @meses, @fecha_inicio)), @fecha_corte);

    IF @horas < 0
        SET @horas = 0;

    RETURN @horas;
END
GO

--Consultar antiguedad en texto
USE InstitutoTECNIC;
GO
CREATE FUNCTION dbo.fn_AntiguedadTexto
(
    @anios  INT,
    @meses  INT,
    @dias   INT,
    @horas  INT
)
RETURNS VARCHAR(200)
AS
BEGIN
    IF @anios = 0 AND @meses = 0 AND @dias = 0 AND @horas = 0
        RETURN N'Sin antigüedad registrada';

    RETURN LTRIM(RTRIM(CONCAT(
        CASE WHEN @anios > 0 THEN CONCAT(@anios, N' año(s) ') ELSE '' END,
        CASE WHEN @meses > 0 THEN CONCAT(@meses, N' mes(es) ') ELSE '' END,
        CASE WHEN @dias > 0 THEN CONCAT(@dias, N' día(s) ') ELSE '' END,
        CASE WHEN @horas > 0 THEN CONCAT(@horas, N' hora(s)') ELSE '' END
    )));
END
GO

--Consultar desglose de antiguedad del profesor
USE InstitutoTECNIC;
GO
CREATE FUNCTION dbo.fn_AntiguedadProfesorDesglose
(
    @codigo_interno_profesor INT,
    @codigo_oficial          VARCHAR(20),
    @fecha_corte             DATE
)
RETURNS @Desglose TABLE
(
    meses_totales INT NOT NULL,
    anios         INT NOT NULL,
    meses         INT NOT NULL,
    dias          INT NOT NULL,
    horas         INT NOT NULL
)
AS
BEGIN
    DECLARE @meses_totales   INT;
    DECLARE @dias_restantes  INT;
    DECLARE @horas_restantes INT;
    DECLARE @ahora           DATETIME = GETDATE();

    SELECT @meses_totales = ISNULL(SUM(
        dbo.fn_MesesImparticion(
            ap.fecha_inicio_imparticion,
            ap.fecha_fin_imparticion,
            @fecha_corte
        )
    ), 0)
    FROM AsignaturaProfesor ap
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    WHERE ap.codigo_interno_profesor = @codigo_interno_profesor
      AND a.codigo_oficial = @codigo_oficial
      AND ap.fecha_inicio_imparticion IS NOT NULL
      AND ap.fecha_inicio_imparticion <= @fecha_corte;

    SELECT @dias_restantes = ISNULL(SUM(
        dbo.fn_DiasImparticionActiva(
            ap.fecha_inicio_imparticion,
            ap.fecha_fin_imparticion,
            @fecha_corte
        )
    ), 0)
    FROM AsignaturaProfesor ap
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    WHERE ap.codigo_interno_profesor = @codigo_interno_profesor
      AND a.codigo_oficial = @codigo_oficial
      AND ap.fecha_inicio_imparticion IS NOT NULL
      AND ap.fecha_inicio_imparticion <= @fecha_corte;

    SELECT @horas_restantes = ISNULL(SUM(
        dbo.fn_HorasImparticionActiva(
            ap.fecha_inicio_imparticion,
            ap.fecha_fin_imparticion,
            @ahora
        )
    ), 0)
    FROM AsignaturaProfesor ap
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    WHERE ap.codigo_interno_profesor = @codigo_interno_profesor
      AND a.codigo_oficial = @codigo_oficial
      AND ap.fecha_inicio_imparticion IS NOT NULL
      AND ap.fecha_inicio_imparticion <= @fecha_corte;

    INSERT INTO @Desglose (meses_totales, anios, meses, dias, horas)
    VALUES (@meses_totales, @meses_totales / 12, @meses_totales % 12, @dias_restantes, @horas_restantes);

    RETURN;
END
GO

--Actualizar antiguedad de profesores en asignaturas
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaProfesor_ActualizarAntiguedad
    @codigo_interno_profesor INT = NULL,
    @codigo_oficial          VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    ;WITH Asignaciones AS (
        SELECT pa.id_asignatura_profesor,
               pa.codigo_interno_profesor,
               a.codigo_oficial,
               COALESCE(pa.fecha_fin_imparticion, @hoy) AS fecha_corte_fila
        FROM AsignaturaProfesor pa
        INNER JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura
        WHERE (@codigo_interno_profesor IS NULL OR pa.codigo_interno_profesor = @codigo_interno_profesor)
          AND (@codigo_oficial IS NULL OR a.codigo_oficial = @codigo_oficial)
    ),
    MesesPorFila AS (
        SELECT af.id_asignatura_profesor,
               MesesTotal = SUM(
                   dbo.fn_MesesImparticion(
                       pa2.fecha_inicio_imparticion,
                       pa2.fecha_fin_imparticion,
                       af.fecha_corte_fila
                   )
               )
        FROM Asignaciones af
        INNER JOIN AsignaturaProfesor pa2
            ON pa2.codigo_interno_profesor = af.codigo_interno_profesor
        INNER JOIN Asignatura a2
            ON a2.codigo_interno_asignatura = pa2.codigo_interno_asignatura
           AND a2.codigo_oficial = af.codigo_oficial
        WHERE pa2.fecha_inicio_imparticion IS NOT NULL
          AND pa2.fecha_inicio_imparticion <= af.fecha_corte_fila
        GROUP BY af.id_asignatura_profesor
    )
    UPDATE pa
    SET antiguedad_profesor = m.MesesTotal / 12
    FROM AsignaturaProfesor pa
    INNER JOIN MesesPorFila m ON m.id_asignatura_profesor = pa.id_asignatura_profesor;
END
GO

--Asignar una asignatura a un profesor
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaProfesor_Asignar
    @codigo_interno_profesor   INT,
    @codigo_interno_asignatura INT,
    @antiguedad_profesor       INT = NULL,
    @fecha_inicio_imparticion  DATE = NULL,
    @fecha_fin_imparticion     DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_nuevo       INT;
    DECLARE @codigo_oficial VARCHAR(20);

    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
       OR NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: Profesor o asignatura no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1 FROM AsignaturaProfesor
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura
    )
    BEGIN
        RAISERROR('Error: La asignatura ya tiene un profesor asignado.', 16, 1);
        RETURN;
    END

    SELECT @codigo_oficial = codigo_oficial
    FROM Asignatura
    WHERE codigo_interno_asignatura = @codigo_interno_asignatura;

    INSERT INTO AsignaturaProfesor (codigo_interno_profesor, codigo_interno_asignatura,
                                    antiguedad_profesor, fecha_inicio_imparticion, fecha_fin_imparticion)
    VALUES (@codigo_interno_profesor, @codigo_interno_asignatura,
            ISNULL(@antiguedad_profesor, 0), @fecha_inicio_imparticion, @fecha_fin_imparticion);

    SET @id_nuevo = SCOPE_IDENTITY();

    EXEC sp_AsignaturaProfesor_ActualizarAntiguedad
        @codigo_interno_profesor = @codigo_interno_profesor,
        @codigo_oficial = @codigo_oficial;

    SELECT @id_nuevo AS id_asignatura_profesor_creado;
END
GO

--Obtener asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaProfesor_Obtener
    @id_asignatura_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaProfesor WHERE id_asignatura_profesor = @id_asignatura_profesor)
    BEGIN
        RAISERROR('Error: La asignacion profesor-asignatura con ID %d no existe.', 16, 1, @id_asignatura_profesor);
        RETURN;
    END
    SELECT pa.id_asignatura_profesor, pa.codigo_interno_profesor, pa.codigo_interno_asignatura,
           pa.antiguedad_profesor, pa.fecha_inicio_imparticion, pa.fecha_fin_imparticion,
           p.nombre_profesor, p.apellido1_profesor, a.nombre_asignatura, a.codigo_oficial
    FROM AsignaturaProfesor pa
    JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura
    WHERE pa.id_asignatura_profesor = @id_asignatura_profesor;
END
GO

--Actualizar asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaProfesor_Actualizar
    @id_asignatura_profesor   INT,
    @fecha_inicio_imparticion DATE = NULL,
    @fecha_fin_imparticion    DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaProfesor WHERE id_asignatura_profesor = @id_asignatura_profesor)
    BEGIN
        RAISERROR('Error: La asignacion profesor-asignatura con ID %d no existe.', 16, 1, @id_asignatura_profesor);
        RETURN;
    END
    IF @fecha_inicio_imparticion IS NOT NULL AND @fecha_fin_imparticion IS NOT NULL
       AND @fecha_fin_imparticion < @fecha_inicio_imparticion
    BEGIN
        RAISERROR('Error: La fecha fin no puede ser anterior a la fecha inicio.', 16, 1);
        RETURN;
    END
    UPDATE AsignaturaProfesor
       SET fecha_inicio_imparticion = COALESCE(@fecha_inicio_imparticion, fecha_inicio_imparticion),
           fecha_fin_imparticion = COALESCE(@fecha_fin_imparticion, fecha_fin_imparticion)
     WHERE id_asignatura_profesor = @id_asignatura_profesor;
END
GO

--Eliminar asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaProfesor_Eliminar
    @id_asignatura_profesor INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @trigger_deshabilitado BIT = 0;

    IF NOT EXISTS (SELECT 1 FROM AsignaturaProfesor WHERE id_asignatura_profesor = @id_asignatura_profesor)
    BEGIN
        RAISERROR('Error: La asignacion profesor-asignatura con ID %d no existe.', 16, 1, @id_asignatura_profesor);
        RETURN;
    END

    BEGIN TRY
        EXEC('DISABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');
        SET @trigger_deshabilitado = 1;

        DELETE FROM AsignaturaProfesor WHERE id_asignatura_profesor = @id_asignatura_profesor;

        EXEC('ENABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');
        SET @trigger_deshabilitado = 0;
    END TRY
    BEGIN CATCH
        IF @trigger_deshabilitado = 1
            EXEC('ENABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');

        THROW;
    END CATCH
END
GO

--Crear una asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Insertar
    @codigo_oficial                 VARCHAR(20),
    @nombre_asignatura              VARCHAR(100),
    @duracion_horas_asignatura      INT,
    @id_aula                        INT,
    @id_periodo                     INT,
    @codigo_interno_profesor        INT,
    @antiguedad_profesor            INT = NULL,
    @fecha_inicio_imparticion_profe DATE = NULL,
    @fecha_fin_imparticion_profe    DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @codigo_interno_asignatura INT;

    IF @duracion_horas_asignatura <= 0
    BEGIN
        RAISERROR('Error: La duracion en horas debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula indicada no existe.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo indicado no existe.', 16, 1);
        RETURN;
    END
    IF @codigo_interno_profesor IS NULL
    BEGIN
        RAISERROR('Error: Toda asignatura debe tener un profesor asignado.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor indicado no existe.', 16, 1);
        RETURN;
    END

    INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas_asignatura, id_aula, id_periodo)
    VALUES (@codigo_oficial, @nombre_asignatura, @duracion_horas_asignatura, @id_aula, @id_periodo);

    SET @codigo_interno_asignatura = SCOPE_IDENTITY();

    EXEC sp_AsignaturaProfesor_Asignar
        @codigo_interno_profesor = @codigo_interno_profesor,
        @codigo_interno_asignatura = @codigo_interno_asignatura,
        @antiguedad_profesor = @antiguedad_profesor,
        @fecha_inicio_imparticion = @fecha_inicio_imparticion_profe,
        @fecha_fin_imparticion = @fecha_fin_imparticion_profe;

    SELECT @codigo_interno_asignatura AS codigo_interno_asignatura_creado;
END
GO

USE InstitutoTECNIC;
GO
--Consultar la antiguedad actual de un profesor
CREATE PROCEDURE sp_AsignaturaProfesor_AntiguedadActual
    @codigo_interno_profesor   INT,
    @codigo_oficial            VARCHAR(20) = NULL,
    @codigo_interno_asignatura INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    IF @codigo_oficial IS NULL AND @codigo_interno_asignatura IS NOT NULL
    BEGIN
        SELECT @codigo_oficial = codigo_oficial
        FROM Asignatura
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura;
    END

    IF @codigo_oficial IS NULL
    BEGIN
        RAISERROR('Error: Debe indicar el codigo oficial o el codigo interno de la asignatura.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
    BEGIN
        RAISERROR('Error: El profesor no existe.', 16, 1);
        RETURN;
    END

    SELECT p.codigo_interno_profesor,
           p.nombre_profesor,
           p.apellido1_profesor,
           @codigo_oficial AS codigo_oficial,
           a_ref.nombre_asignatura,
           @hoy AS fecha_consulta,
           d.anios,
           d.meses,
           d.dias,
           d.horas,
           dbo.fn_AntiguedadTexto(d.anios, d.meses, d.dias, d.horas) AS antiguedad_texto
    FROM Profesor p
    CROSS APPLY dbo.fn_AntiguedadProfesorDesglose(
        @codigo_interno_profesor, @codigo_oficial, @hoy
    ) d
    OUTER APPLY (
        SELECT TOP 1 nombre_asignatura
        FROM Asignatura
        WHERE codigo_oficial = @codigo_oficial
        ORDER BY codigo_interno_asignatura
    ) a_ref
    WHERE p.codigo_interno_profesor = @codigo_interno_profesor;
END
GO

USE InstitutoTECNIC;
GO
--Consultar la antiguedad de una asignatura
CREATE PROCEDURE sp_AsignaturaProfesor_ConsultarAntiguedad
    @codigo_interno_profesor   INT,
    @codigo_oficial            VARCHAR(20) = NULL,
    @codigo_interno_asignatura INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    EXEC sp_AsignaturaProfesor_AntiguedadActual
        @codigo_interno_profesor = @codigo_interno_profesor,
        @codigo_oficial = @codigo_oficial,
        @codigo_interno_asignatura = @codigo_interno_asignatura;

    IF @codigo_oficial IS NULL AND @codigo_interno_asignatura IS NOT NULL
        SELECT @codigo_oficial = codigo_oficial
        FROM Asignatura
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura;

    SELECT pa.id_asignatura_profesor,
           a.codigo_interno_asignatura,
           pe.nombre_periodo,
           pe.annio,
           pa.fecha_inicio_imparticion,
           pa.fecha_fin_imparticion,
           dbo.fn_MesesImparticion(
               pa.fecha_inicio_imparticion,
               pa.fecha_fin_imparticion,
               COALESCE(pa.fecha_fin_imparticion, @hoy)
           ) AS meses_periodo,
           dbo.fn_DiasImparticionActiva(
               pa.fecha_inicio_imparticion,
               pa.fecha_fin_imparticion,
               @hoy
           ) AS dias_periodo_activo,
           dbo.fn_HorasImparticionActiva(
               pa.fecha_inicio_imparticion,
               pa.fecha_fin_imparticion,
               GETDATE()
           ) AS horas_periodo_activo,
           pa.antiguedad_profesor AS antiguedad_anios_registrada
    FROM AsignaturaProfesor pa
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura
    INNER JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    WHERE pa.codigo_interno_profesor = @codigo_interno_profesor
      AND a.codigo_oficial = @codigo_oficial
    ORDER BY pa.fecha_inicio_imparticion;
END
GO

USE InstitutoTECNIC;
GO
--Crear una asignatura a un ciclo
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

--Obtener enlace asignatura-ciclo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCiclo_Obtener
    @id_asignatura_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaCiclo WHERE id_asignatura_ciclo = @id_asignatura_ciclo)
    BEGIN
        RAISERROR('Error: El enlace asignatura-ciclo con ID %d no existe.', 16, 1, @id_asignatura_ciclo);
        RETURN;
    END
    SELECT ac.id_asignatura_ciclo, ac.codigo_interno_asignatura, ac.codigo_interno_ciclo,
           a.nombre_asignatura, c.nombre_ciclo
    FROM AsignaturaCiclo ac
    JOIN Asignatura a ON a.codigo_interno_asignatura = ac.codigo_interno_asignatura
    JOIN Ciclo c ON c.codigo_interno_ciclo = ac.codigo_interno_ciclo
    WHERE ac.id_asignatura_ciclo = @id_asignatura_ciclo;
END
GO

--Eliminar enlace asignatura-ciclo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCiclo_Eliminar
    @id_asignatura_ciclo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaCiclo WHERE id_asignatura_ciclo = @id_asignatura_ciclo)
    BEGIN
        RAISERROR('Error: El enlace asignatura-ciclo con ID %d no existe.', 16, 1, @id_asignatura_ciclo);
        RETURN;
    END
    DELETE FROM AsignaturaCiclo WHERE id_asignatura_ciclo = @id_asignatura_ciclo;
END
GO

USE InstitutoTECNIC;
GO
--Crear una asignatura a un curso
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

--Obtener enlace asignatura-curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCurso_Obtener
    @id_asignatura_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaCurso WHERE id_asignatura_curso = @id_asignatura_curso)
    BEGIN
        RAISERROR('Error: El enlace asignatura-curso con ID %d no existe.', 16, 1, @id_asignatura_curso);
        RETURN;
    END
    SELECT acu.id_asignatura_curso, acu.codigo_interno_asignatura, acu.id_curso,
           a.nombre_asignatura, c.nivel_curso
    FROM AsignaturaCurso acu
    JOIN Asignatura a ON a.codigo_interno_asignatura = acu.codigo_interno_asignatura
    JOIN Curso c ON c.id_curso = acu.id_curso
    WHERE acu.id_asignatura_curso = @id_asignatura_curso;
END
GO

--Eliminar enlace asignatura-curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaCurso_Eliminar
    @id_asignatura_curso INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaCurso WHERE id_asignatura_curso = @id_asignatura_curso)
    BEGIN
        RAISERROR('Error: El enlace asignatura-curso con ID %d no existe.', 16, 1, @id_asignatura_curso);
        RETURN;
    END
    DELETE FROM AsignaturaCurso WHERE id_asignatura_curso = @id_asignatura_curso;
END
GO

--Obtener una asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Obtener
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END
    SELECT a.codigo_interno_asignatura, a.codigo_oficial, a.nombre_asignatura,
           pe.nombre_periodo, pe.annio, a.duracion_horas_asignatura,
           p.nombre_profesor, p.apellido1_profesor, au.nombre_aula,
           a.id_aula, a.id_periodo
    FROM Asignatura a
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    LEFT JOIN AsignaturaProfesor pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    LEFT JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    JOIN Aula au ON a.id_aula = au.id_aula
    WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura;
END
GO

--Actualizar una asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Actualizar
    @codigo_interno_asignatura INT,
    @nombre_asignatura         VARCHAR(100),
    @duracion_horas_asignatura INT,
    @id_aula                   INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END
    IF @duracion_horas_asignatura <= 0
    BEGIN
        RAISERROR('Error: La duracion en horas debe ser mayor a 0.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Aula WHERE id_aula = @id_aula)
    BEGIN
        RAISERROR('Error: El aula indicada no existe.', 16, 1);
        RETURN;
    END
    UPDATE Asignatura
       SET nombre_asignatura = @nombre_asignatura,
           duracion_horas_asignatura = @duracion_horas_asignatura,
           id_aula = @id_aula
     WHERE codigo_interno_asignatura = @codigo_interno_asignatura;
END
GO

--Eliminar una asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asignatura_Eliminar
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @trigger_deshabilitado BIT = 0;

    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura con ID %d no existe.', 16, 1, @codigo_interno_asignatura);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM HorarioAsignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM AsignaturaMatricula WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM NotaFinal WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM Asistencia WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM AsignaturaCiclo WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM AsignaturaCurso WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM AsignaturaPrerrequisito WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: No se puede eliminar la asignatura porque tiene registros dependientes.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        EXEC('DISABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');
        SET @trigger_deshabilitado = 1;

        DELETE FROM AsignaturaProfesor WHERE codigo_interno_asignatura = @codigo_interno_asignatura;
        DELETE FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura;

        EXEC('ENABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');
        SET @trigger_deshabilitado = 0;
    END TRY
    BEGIN CATCH
        IF @trigger_deshabilitado = 1
            EXEC('ENABLE TRIGGER tr_AsignaturaProfesor_NoEliminarProfesor ON AsignaturaProfesor');

        THROW;
    END CATCH
END
GO

-- CRUD: ESTUDIANTE
USE InstitutoTECNIC;
GO
--Crear un estudiante
CREATE PROCEDURE sp_Estudiante_Insertar
    @cedula_estudiante        VARCHAR(20),
    @nombre_estudiante        VARCHAR(50),
    @apellido1_estudiante     VARCHAR(50),
    @apellido2_estudiante     VARCHAR(50) = NULL,
    @seguro_social_estudiante INT = NULL,
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
    IF @cedula_estudiante NOT LIKE '[1-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
       AND @cedula_estudiante NOT LIKE '[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]'
    BEGIN
        RAISERROR('Error: Formato de cedula no valido (CR: 1-2345-6789 o pasaporte internacional).', 16, 1);
        RETURN;
    END
    IF @seguro_social_estudiante IS NOT NULL AND EXISTS (
        SELECT 1 FROM Estudiante WHERE seguro_social_estudiante = @seguro_social_estudiante
    )
    BEGIN
        RAISERROR('Error: Ya existe un estudiante con ese numero de seguro social.', 16, 1);
        RETURN;
    END
    IF @fecha_nacimiento IS NOT NULL AND @fecha_ingreso IS NOT NULL AND @fecha_ingreso <= @fecha_nacimiento
    BEGIN
        RAISERROR('Error: La fecha de ingreso debe ser posterior a la de nacimiento.', 16, 1);
        RETURN;
    END
    IF @fecha_nacimiento IS NOT NULL AND COALESCE(@fecha_ingreso, CAST(GETDATE() AS DATE)) < DATEADD(YEAR, 12, @fecha_nacimiento)
    BEGIN
        RAISERROR('Error: El estudiante debe tener al menos 12 anos al momento del ingreso.', 16, 1);
        RETURN;
    END
    INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, apellido1_estudiante,
                            apellido2_estudiante, seguro_social_estudiante,
                            telefono_estudiante, fecha_nacimiento, fecha_ingreso)
    VALUES (@cedula_estudiante, @nombre_estudiante, @apellido1_estudiante,
            @apellido2_estudiante, @seguro_social_estudiante,
            @telefono_estudiante, @fecha_nacimiento, COALESCE(@fecha_ingreso, CAST(GETDATE() AS DATE)));
    SELECT SCOPE_IDENTITY() AS id_estudiante_creado;
END
GO

--Actualizar un estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Estudiante_Actualizar
    @id_estudiante        INT,
    @telefono_estudiante  VARCHAR(20) = NULL,
    @nombre_estudiante    VARCHAR(50) = NULL,
    @apellido1_estudiante VARCHAR(50) = NULL,
    @apellido2_estudiante VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante con ID %d no existe.', 16, 1, @id_estudiante);
        RETURN;
    END
    UPDATE Estudiante
       SET telefono_estudiante  = COALESCE(@telefono_estudiante, telefono_estudiante),
           nombre_estudiante    = COALESCE(@nombre_estudiante, nombre_estudiante),
           apellido1_estudiante = COALESCE(@apellido1_estudiante, apellido1_estudiante),
           apellido2_estudiante = COALESCE(@apellido2_estudiante, apellido2_estudiante)
     WHERE id_estudiante = @id_estudiante;
END
GO

--Eliminar un estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Estudiante_Eliminar
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
    IF EXISTS (SELECT 1 FROM NotaFinal WHERE id_estudiante = @id_estudiante)
       OR EXISTS (SELECT 1 FROM Asistencia WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: No se puede eliminar el estudiante porque tiene notas o asistencias registradas.', 16, 1);
        RETURN;
    END
    DELETE FROM Estudiante WHERE id_estudiante = @id_estudiante;
END
GO

--Obtener un estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Estudiante_Obtener
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante con ID %d no existe.', 16, 1, @id_estudiante);
        RETURN;
    END
    SELECT e.id_estudiante, e.cedula_estudiante, e.nombre_estudiante, e.apellido1_estudiante,
           e.apellido2_estudiante, u.correo_usuario, e.telefono_estudiante,
           e.seguro_social_estudiante, e.fecha_nacimiento, e.fecha_ingreso, e.id_usuario
    FROM Estudiante e
    LEFT JOIN Usuario u ON e.id_usuario = u.id_usuario
    WHERE e.id_estudiante = @id_estudiante;
END
GO

-- CRUD: BLOQUE HORARIO
USE InstitutoTECNIC;
GO
--Crear un bloque horario
CREATE PROCEDURE sp_BloqueHorario_Insertar
    @num_bloque         INT,
    @hora_inicio_bloque TIME,
    @hora_fin_bloque    TIME
AS
BEGIN
    SET NOCOUNT ON;
    IF @num_bloque NOT BETWEEN 1 AND 6 OR @hora_fin_bloque <= @hora_inicio_bloque
    BEGIN
        RAISERROR('Error: Bloque u horario no valido.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: Ya existe ese bloque en el catalogo.', 16, 1);
        RETURN;
    END
    INSERT INTO BloqueHorario (num_bloque, hora_inicio_bloque, hora_fin_bloque)
    VALUES (@num_bloque, @hora_inicio_bloque, @hora_fin_bloque);
END
GO

--Obtener un bloque horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_BloqueHorario_Obtener
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: El bloque %d no existe.', 16, 1, @num_bloque);
        RETURN;
    END
    SELECT num_bloque, hora_inicio_bloque, hora_fin_bloque
    FROM BloqueHorario WHERE num_bloque = @num_bloque;
END
GO

--Actualizar un bloque horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_BloqueHorario_Actualizar
    @num_bloque         INT,
    @hora_inicio_bloque TIME,
    @hora_fin_bloque    TIME
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: El bloque %d no existe.', 16, 1, @num_bloque);
        RETURN;
    END
    IF @num_bloque NOT BETWEEN 1 AND 6 OR @hora_fin_bloque <= @hora_inicio_bloque
    BEGIN
        RAISERROR('Error: Bloque u horario no valido.', 16, 1);
        RETURN;
    END
    UPDATE BloqueHorario
       SET hora_inicio_bloque = @hora_inicio_bloque, hora_fin_bloque = @hora_fin_bloque
     WHERE num_bloque = @num_bloque;
END
GO

--Eliminar un bloque horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_BloqueHorario_Eliminar
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: El bloque %d no existe.', 16, 1, @num_bloque);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Horario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: No se puede eliminar el bloque porque tiene horarios asociados.', 16, 1);
        RETURN;
    END
    DELETE FROM BloqueHorario WHERE num_bloque = @num_bloque;
END
GO

-- CRUD: HORARIO
USE InstitutoTECNIC;
GO
--Crear un horario bloque
CREATE PROCEDURE sp_HorarioBloque_Insertar
    @dia_semana VARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
    BEGIN
        RAISERROR('Error: Dia de la semana no valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: El bloque no existe en el catalogo institucional.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Horario WHERE dia_semana = @dia_semana AND num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: Ya existe un bloque horario para ese dia y numero de bloque.', 16, 1);
        RETURN;
    END

    INSERT INTO Horario (dia_semana, num_bloque)
    VALUES (@dia_semana, @num_bloque);

    SELECT SCOPE_IDENTITY() AS id_horario_creado;
END
GO

--Obtener un horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Horario_Obtener
    @id_horario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Horario WHERE id_horario = @id_horario)
    BEGIN
        RAISERROR('Error: El horario con ID %d no existe.', 16, 1, @id_horario);
        RETURN;
    END
    SELECT h.id_horario, h.dia_semana, h.num_bloque, bh.hora_inicio_bloque, bh.hora_fin_bloque
    FROM Horario h
    JOIN BloqueHorario bh ON bh.num_bloque = h.num_bloque
    WHERE h.id_horario = @id_horario;
END
GO

--Actualizar un horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Horario_Actualizar
    @id_horario INT,
    @dia_semana VARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Horario WHERE id_horario = @id_horario)
    BEGIN
        RAISERROR('Error: El horario con ID %d no existe.', 16, 1, @id_horario);
        RETURN;
    END
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
    BEGIN
        RAISERROR('Error: Dia de la semana no valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM BloqueHorario WHERE num_bloque = @num_bloque)
    BEGIN
        RAISERROR('Error: El bloque no existe en el catalogo institucional.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1 FROM Horario
        WHERE dia_semana = @dia_semana AND num_bloque = @num_bloque AND id_horario <> @id_horario
    )
    BEGIN
        RAISERROR('Error: Ya existe un bloque horario para ese dia y numero de bloque.', 16, 1);
        RETURN;
    END
    UPDATE Horario SET dia_semana = @dia_semana, num_bloque = @num_bloque WHERE id_horario = @id_horario;
END
GO

--Eliminar un horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Horario_Eliminar
    @id_horario INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Horario WHERE id_horario = @id_horario)
    BEGIN
        RAISERROR('Error: El horario con ID %d no existe.', 16, 1, @id_horario);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM HorarioAsignatura WHERE id_horario = @id_horario)
    BEGIN
        RAISERROR('Error: No se puede eliminar el horario porque tiene asignaturas asignadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Horario WHERE id_horario = @id_horario;
END
GO

USE InstitutoTECNIC;
GO
--Asignar un horario a una asignatura
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

--Obtener asignacion horario-asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioAsignatura_Obtener
    @id_horario_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM HorarioAsignatura WHERE id_horario_asignatura = @id_horario_asignatura)
    BEGIN
        RAISERROR('Error: La asignacion horario-asignatura con ID %d no existe.', 16, 1, @id_horario_asignatura);
        RETURN;
    END
    SELECT ha.id_horario_asignatura, ha.id_horario, ha.codigo_interno_asignatura,
           h.dia_semana, h.num_bloque, a.nombre_asignatura
    FROM HorarioAsignatura ha
    JOIN Horario h ON h.id_horario = ha.id_horario
    JOIN Asignatura a ON a.codigo_interno_asignatura = ha.codigo_interno_asignatura
    WHERE ha.id_horario_asignatura = @id_horario_asignatura;
END
GO

--Eliminar asignacion horario-asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioAsignatura_Eliminar
    @id_horario_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM HorarioAsignatura WHERE id_horario_asignatura = @id_horario_asignatura)
    BEGIN
        RAISERROR('Error: La asignacion horario-asignatura con ID %d no existe.', 16, 1, @id_horario_asignatura);
        RETURN;
    END
    DELETE FROM HorarioAsignatura WHERE id_horario_asignatura = @id_horario_asignatura;
END
GO


-- CRUD: PRERREQUISITO
USE InstitutoTECNIC;
GO
--Crear un prerrequisito
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
    IF NOT EXISTS (
        SELECT 1 FROM Asignatura WHERE codigo_oficial = @codigo_oficial_asignatura_prerequerida
    )
    BEGIN
        RAISERROR('Error: El codigo oficial del prerrequisito no existe en el catalogo de asignaturas.', 16, 1);
        RETURN;
    END
    INSERT INTO Prerrequisito (codigo_oficial_asignatura_prerequerida, estado_prerrequisito, nombre_asignatura_prerequisito)
    VALUES (@codigo_oficial_asignatura_prerequerida, @estado_prerrequisito, @nombre_asignatura_prerequisito);
    SELECT SCOPE_IDENTITY() AS id_prerrequisito_creado;
END
GO

--Obtener un prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Prerrequisito_Obtener
    @id_prerrequisito INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: El prerrequisito con ID %d no existe.', 16, 1, @id_prerrequisito);
        RETURN;
    END
    SELECT id_prerrequisito, codigo_oficial_asignatura_prerequerida, estado_prerrequisito,
           nombre_asignatura_prerequisito
    FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito;
END
GO

--Actualizar un prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Prerrequisito_Actualizar
    @id_prerrequisito               INT,
    @estado_prerrequisito           VARCHAR(20),
    @nombre_asignatura_prerequisito VARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: El prerrequisito con ID %d no existe.', 16, 1, @id_prerrequisito);
        RETURN;
    END
    IF @estado_prerrequisito NOT IN ('Activo', 'Inactivo', 'Eliminado')
    BEGIN
        RAISERROR('Error: Estado de prerrequisito no valido.', 16, 1);
        RETURN;
    END
    UPDATE Prerrequisito
       SET estado_prerrequisito = @estado_prerrequisito,
           nombre_asignatura_prerequisito = COALESCE(@nombre_asignatura_prerequisito, nombre_asignatura_prerequisito)
     WHERE id_prerrequisito = @id_prerrequisito;
END
GO

--Eliminar un prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Prerrequisito_Eliminar
    @id_prerrequisito INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: El prerrequisito con ID %d no existe.', 16, 1, @id_prerrequisito);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM AsignaturaPrerrequisito WHERE id_prerrequisito = @id_prerrequisito)
    BEGIN
        RAISERROR('Error: No se puede eliminar el prerrequisito porque esta asignado a asignaturas.', 16, 1);
        RETURN;
    END
    DELETE FROM Prerrequisito WHERE id_prerrequisito = @id_prerrequisito;
END
GO

USE InstitutoTECNIC;
GO
--Asignar un prerrequisito a una asignatura
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

--Obtener enlace asignatura-prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaPrerrequisito_Obtener
    @id_asignatura_prerrequisito INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaPrerrequisito WHERE id_asignatura_prerrequisito = @id_asignatura_prerrequisito)
    BEGIN
        RAISERROR('Error: El enlace asignatura-prerrequisito con ID %d no existe.', 16, 1, @id_asignatura_prerrequisito);
        RETURN;
    END
    SELECT ap.id_asignatura_prerrequisito, ap.codigo_interno_asignatura, ap.id_prerrequisito,
           a.nombre_asignatura, p.nombre_asignatura_prerequisito
    FROM AsignaturaPrerrequisito ap
    JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    JOIN Prerrequisito p ON p.id_prerrequisito = ap.id_prerrequisito
    WHERE ap.id_asignatura_prerrequisito = @id_asignatura_prerrequisito;
END
GO

--Eliminar enlace asignatura-prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaPrerrequisito_Eliminar
    @id_asignatura_prerrequisito INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaPrerrequisito WHERE id_asignatura_prerrequisito = @id_asignatura_prerrequisito)
    BEGIN
        RAISERROR('Error: El enlace asignatura-prerrequisito con ID %d no existe.', 16, 1, @id_asignatura_prerrequisito);
        RETURN;
    END
    DELETE FROM AsignaturaPrerrequisito WHERE id_asignatura_prerrequisito = @id_asignatura_prerrequisito;
END
GO

-- CRUD: PERIODO
USE InstitutoTECNIC;
GO
--Crear un periodo
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
    IF @nombre_periodo NOT IN ('I-Semestre', 'II-Semestre')
    BEGIN
        RAISERROR('Error: El nombre del periodo debe ser I-Semestre o II-Semestre.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Periodo WHERE nombre_periodo = @nombre_periodo AND annio = @annio)
    BEGIN
        RAISERROR('Error: Ya existe ese periodo para el annio indicado.', 16, 1);
        RETURN;
    END
    INSERT INTO Periodo (nombre_periodo, annio)
    VALUES (@nombre_periodo, @annio);
    SELECT SCOPE_IDENTITY() AS id_periodo_creado;
END
GO

--Obtener un periodo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Periodo_Obtener
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo con ID %d no existe.', 16, 1, @id_periodo);
        RETURN;
    END
    SELECT id_periodo, nombre_periodo, annio FROM Periodo WHERE id_periodo = @id_periodo;
END
GO

--Actualizar un periodo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Periodo_Actualizar
    @id_periodo     INT,
    @nombre_periodo VARCHAR(50),
    @annio          INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo con ID %d no existe.', 16, 1, @id_periodo);
        RETURN;
    END
    IF @annio < 2000 OR @annio > 2100
    BEGIN
        RAISERROR('Error: El annio del periodo no es valido.', 16, 1);
        RETURN;
    END
    IF @nombre_periodo NOT IN ('I-Semestre', 'II-Semestre')
    BEGIN
        RAISERROR('Error: El nombre del periodo debe ser I-Semestre o II-Semestre.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1 FROM Periodo
        WHERE nombre_periodo = @nombre_periodo AND annio = @annio AND id_periodo <> @id_periodo
    )
    BEGIN
        RAISERROR('Error: Ya existe ese periodo para el annio indicado.', 16, 1);
        RETURN;
    END
    UPDATE Periodo SET nombre_periodo = @nombre_periodo, annio = @annio WHERE id_periodo = @id_periodo;
END
GO

--Eliminar un periodo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Periodo_Eliminar
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo con ID %d no existe.', 16, 1, @id_periodo);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Asignatura WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: No se puede eliminar el periodo porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    DELETE FROM Periodo WHERE id_periodo = @id_periodo;
END
GO

-- CRUD: MATRICULA
USE InstitutoTECNIC;
GO
--Crear una matricula
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
    IF @estado_matricula = 'Activa' AND EXISTS (
        SELECT 1 FROM Matricula
        WHERE id_estudiante = @id_estudiante AND estado_matricula = 'Activa'
    )
    BEGIN
        RAISERROR('Error: El estudiante ya tiene una matricula activa.', 16, 1);
        RETURN;
    END
    INSERT INTO Matricula (fecha_matricula, estado_matricula, id_estudiante, id_sede)
    VALUES (COALESCE(@fecha_matricula, GETDATE()), @estado_matricula, @id_estudiante, @id_sede);
    SELECT SCOPE_IDENTITY() AS id_matricula_creada;
END
GO

--Obtener una matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Matricula_Obtener
    @id_matricula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: La matricula con ID %d no existe.', 16, 1, @id_matricula);
        RETURN;
    END
    SELECT m.id_matricula, m.fecha_matricula, m.estado_matricula, m.id_estudiante, m.id_sede,
           e.cedula_estudiante, e.nombre_estudiante, e.apellido1_estudiante, s.nombre_sede
    FROM Matricula m
    JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    JOIN Sede s ON s.id_sede = m.id_sede
    WHERE m.id_matricula = @id_matricula;
END
GO

--Actualizar una matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Matricula_Actualizar
    @id_matricula     INT,
    @estado_matricula VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: La matricula con ID %d no existe.', 16, 1, @id_matricula);
        RETURN;
    END
    IF @estado_matricula NOT IN ('Activa', 'Anulada', 'Finalizada')
    BEGIN
        RAISERROR('Error: Estado de matricula no valido.', 16, 1);
        RETURN;
    END
    IF @estado_matricula = 'Activa' AND EXISTS (
        SELECT 1 FROM Matricula m
        WHERE m.id_estudiante = (SELECT id_estudiante FROM Matricula WHERE id_matricula = @id_matricula)
          AND m.estado_matricula = 'Activa'
          AND m.id_matricula <> @id_matricula
    )
    BEGIN
        RAISERROR('Error: El estudiante ya tiene una matricula activa.', 16, 1);
        RETURN;
    END
    UPDATE Matricula SET estado_matricula = @estado_matricula WHERE id_matricula = @id_matricula;
END
GO

--Eliminar una matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Matricula_Eliminar
    @id_matricula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: La matricula con ID %d no existe.', 16, 1, @id_matricula);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM AsignaturaMatricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: No se puede eliminar la matricula porque tiene asignaturas inscritas.', 16, 1);
        RETURN;
    END
    DELETE FROM Matricula WHERE id_matricula = @id_matricula;
END
GO

USE InstitutoTECNIC;
GO
--Finalizar una matricula
CREATE PROCEDURE sp_Matricula_Finalizar
    @id_matricula INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: La matricula no existe.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula AND estado_matricula <> 'Activa')
    BEGIN
        RAISERROR('Error: Solo se puede finalizar una matricula activa.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM AsignaturaMatricula am
        INNER JOIN Matricula m ON m.id_matricula = am.id_matricula
        WHERE am.id_matricula = @id_matricula
          AND NOT EXISTS (
              SELECT 1
              FROM NotaFinal nf
              WHERE nf.id_estudiante = m.id_estudiante
                AND nf.codigo_interno_asignatura = am.codigo_interno_asignatura
                AND nf.estado_nota IN ('Aprobado', 'Reprobado')
          )
    )
    BEGIN
        RAISERROR('Error: No se puede finalizar la matricula hasta cerrar las notas (Aprobado o Reprobado) de todas las asignaturas matriculadas.', 16, 1);
        RETURN;
    END

    UPDATE Matricula SET estado_matricula = 'Finalizada' WHERE id_matricula = @id_matricula;
END
GO


USE InstitutoTECNIC;
GO
--Crear una asignatura a una matricula
CREATE PROCEDURE sp_AsignaturaMatricula_Insertar
    @codigo_interno_asignatura INT,
    @id_matricula              INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validar existencia
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
       OR NOT EXISTS (SELECT 1 FROM Matricula WHERE id_matricula = @id_matricula)
    BEGIN
        RAISERROR('Error: Asignatura o matricula no existe.', 16, 1);
        RETURN;
    END

    -- Validar que la matricula este activa
    IF NOT EXISTS (
        SELECT 1 FROM Matricula
        WHERE id_matricula = @id_matricula AND estado_matricula = 'Activa'
    )
    BEGIN
        RAISERROR('Error: Solo se pueden inscribir asignaturas en matriculas activas.', 16, 1);
        RETURN;
    END

    -- Validar que la asignatura no sea historica respecto al año de matricula
    IF EXISTS (
        SELECT 1
        FROM Asignatura a
        JOIN AsignaturaProfesor pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
        JOIN Matricula m ON m.id_matricula = @id_matricula
        WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
          AND pa.fecha_fin_imparticion IS NOT NULL
          AND YEAR(pa.fecha_fin_imparticion) < YEAR(m.fecha_matricula)
    )
    BEGIN
        RAISERROR('Error: La fecha fin de imparticion del profesor es anterior al annio de la matricula.', 16, 1);
        RETURN;
    END

    -- Validar que la asignatura este asociada a algun curso
    IF NOT EXISTS (
        SELECT 1 FROM AsignaturaCurso
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura
    )
    BEGIN
        RAISERROR('Error: La asignatura no esta asociada a ningun curso.', 16, 1);
        RETURN;
    END

    -- Validar que el periodo de la asignatura coincida con el año de la matricula
    IF EXISTS (
        SELECT 1
        FROM Asignatura a
        JOIN Periodo pe ON pe.id_periodo = a.id_periodo
        JOIN Matricula m ON m.id_matricula = @id_matricula
        WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
          AND pe.annio <> YEAR(m.fecha_matricula)
    )
    BEGIN
        RAISERROR('Error: El periodo de la asignatura no coincide con el annio de la matricula.', 16, 1);
        RETURN;
    END

    -- Validar que la asignatura pertenezca al mismo CICLO que las demas de la matricula
    IF EXISTS (SELECT 1 FROM AsignaturaMatricula WHERE id_matricula = @id_matricula)
       AND NOT EXISTS (
        SELECT ac1.codigo_interno_ciclo
        FROM AsignaturaCurso asc1
        JOIN Curso ac1 ON ac1.id_curso = asc1.id_curso
        WHERE asc1.codigo_interno_asignatura = @codigo_interno_asignatura
        INTERSECT
        SELECT ac2.codigo_interno_ciclo
        FROM AsignaturaMatricula am
        JOIN AsignaturaCurso asc2 ON asc2.codigo_interno_asignatura = am.codigo_interno_asignatura
        JOIN Curso ac2 ON ac2.id_curso = asc2.id_curso
        WHERE am.id_matricula = @id_matricula
    )
    BEGIN
        RAISERROR('Error: La asignatura no pertenece al mismo ciclo que las demas de la matricula.', 16, 1);
        RETURN;
    END

    -- Validar que la asignatura pertenezca a la misma sede de la matricula
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

    -- Validar capacidad del aula
    IF (
        SELECT COUNT(*)
        FROM AsignaturaMatricula am
        JOIN Matricula m ON m.id_matricula = am.id_matricula
        WHERE am.codigo_interno_asignatura = @codigo_interno_asignatura
          AND m.estado_matricula = 'Activa'
    ) >= (
        SELECT au.capacidad
        FROM Asignatura a
        JOIN Aula au ON au.id_aula = a.id_aula
        WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
    )
    BEGIN
        RAISERROR('Error: La asignatura ya alcanzo la capacidad maxima del aula.', 16, 1);
        RETURN;
    END

    INSERT INTO AsignaturaMatricula (codigo_interno_asignatura, id_matricula)
    VALUES (@codigo_interno_asignatura, @id_matricula);

    SELECT SCOPE_IDENTITY() AS id_asignatura_matricula_creada;
END
GO

--Obtener inscripcion asignatura-matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaMatricula_Obtener
    @id_asignatura_matricula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaMatricula WHERE id_asignatura_matricula = @id_asignatura_matricula)
    BEGIN
        RAISERROR('Error: La inscripcion asignatura-matricula con ID %d no existe.', 16, 1, @id_asignatura_matricula);
        RETURN;
    END
    SELECT am.id_asignatura_matricula, am.codigo_interno_asignatura, am.id_matricula,
           a.nombre_asignatura, m.estado_matricula, e.cedula_estudiante
    FROM AsignaturaMatricula am
    JOIN Asignatura a ON a.codigo_interno_asignatura = am.codigo_interno_asignatura
    JOIN Matricula m ON m.id_matricula = am.id_matricula
    JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE am.id_asignatura_matricula = @id_asignatura_matricula;
END
GO

--Eliminar inscripcion asignatura-matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturaMatricula_Eliminar
    @id_asignatura_matricula INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM AsignaturaMatricula WHERE id_asignatura_matricula = @id_asignatura_matricula)
    BEGIN
        RAISERROR('Error: La inscripcion asignatura-matricula con ID %d no existe.', 16, 1, @id_asignatura_matricula);
        RETURN;
    END
    DELETE FROM AsignaturaMatricula WHERE id_asignatura_matricula = @id_asignatura_matricula;
END
GO

USE InstitutoTECNIC;
GO
--Consultar si un profesor puede gestionar una asignatura
CREATE FUNCTION dbo.fn_ProfesorPuedeGestionarAsignatura
(
    @id_usuario                INT,
    @codigo_interno_asignatura INT
)
RETURNS BIT
AS
BEGIN
    DECLARE @codigo_interno_profesor INT;

    IF @id_usuario IS NULL
        RETURN 1;

    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id_usuario = @id_usuario AND rol = 'Profesor')
        RETURN 1;

    SELECT @codigo_interno_profesor = codigo_interno_profesor
    FROM Profesor
    WHERE id_usuario = @id_usuario;

    IF @codigo_interno_profesor IS NULL
        RETURN 0;

    IF EXISTS (
        SELECT 1
        FROM AsignaturaProfesor
        WHERE codigo_interno_profesor = @codigo_interno_profesor
          AND codigo_interno_asignatura = @codigo_interno_asignatura
    )
        RETURN 1;

    RETURN 0;
END
GO

-- CRUD: NOTA FINAL
USE InstitutoTECNIC;
GO
--Crear una nota final
CREATE PROCEDURE sp_NotaFinal_Insertar
    @promedio_final            DECIMAL(5,2) = NULL,
    @estado_nota               VARCHAR(20),
    @id_estudiante             INT,
    @codigo_interno_asignatura INT
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
    IF @estado_nota = 'Aprobado' AND @promedio_final < 70
    BEGIN
        RAISERROR('Error: Para aprobar la nota minima es 70.', 16, 1);
        RETURN;
    END
    IF @estado_nota = 'Reprobado' AND @promedio_final >= 70
    BEGIN
        RAISERROR('Error: Con nota 70 o mas el estado debe ser Aprobado.', 16, 1);
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
          AND m.estado_matricula IN ('Activa', 'Finalizada')
    )
    BEGIN
        RAISERROR('Error: El estudiante debe estar matriculado en la asignatura antes de registrar la nota.', 16, 1);
        RETURN;
    END
    IF @estado_nota = 'En curso' AND EXISTS (
        SELECT 1
        FROM Asignatura a
        JOIN Periodo pe ON pe.id_periodo = a.id_periodo
        JOIN AsignaturaMatricula am ON am.codigo_interno_asignatura = a.codigo_interno_asignatura
        JOIN Matricula m ON m.id_matricula = am.id_matricula
        WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
          AND m.id_estudiante = @id_estudiante
          AND m.estado_matricula = 'Activa'
          AND pe.annio <> YEAR(m.fecha_matricula)
    )
    BEGIN
        RAISERROR('Error: La asignatura en curso no corresponde al annio de la matricula activa.', 16, 1);
        RETURN;
    END
    IF dbo.fn_ProfesorPuedeGestionarAsignatura(
            TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT),
            @codigo_interno_asignatura) = 0
    BEGIN
        RAISERROR('Error: El profesor solo puede registrar notas de sus asignaturas.', 16, 1);
        RETURN;
    END
    INSERT INTO NotaFinal (promedio_final, estado_nota, id_estudiante, codigo_interno_asignatura)
    VALUES (@promedio_final, @estado_nota, @id_estudiante, @codigo_interno_asignatura);
    SELECT SCOPE_IDENTITY() AS id_nota_final_creada;
END
GO

--Actualizar una nota final
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotaFinal_Actualizar
    @id_estudiante             INT,
    @codigo_interno_asignatura INT,
    @promedio_final            DECIMAL(5,2),
    @estado_nota               VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    IF @estado_nota NOT IN ('Aprobado', 'Reprobado')
    BEGIN
        RAISERROR('Error: Solo se puede cerrar la nota como Aprobado o Reprobado.', 16, 1);
        RETURN;
    END
    IF @promedio_final IS NULL
    BEGIN
        RAISERROR('Error: El promedio final es obligatorio al cerrar la nota.', 16, 1);
        RETURN;
    END
    IF @estado_nota = 'Aprobado' AND @promedio_final < 70
    BEGIN
        RAISERROR('Error: Para aprobar la nota minima es 70.', 16, 1);
        RETURN;
    END
    IF @estado_nota = 'Reprobado' AND @promedio_final >= 70
    BEGIN
        RAISERROR('Error: Con nota 70 o mas el estado debe ser Aprobado.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1 FROM NotaFinal
        WHERE id_estudiante = @id_estudiante
          AND codigo_interno_asignatura = @codigo_interno_asignatura
    )
    BEGIN
        RAISERROR('Error: No existe una nota registrada para ese estudiante y asignatura.', 16, 1);
        RETURN;
    END
    IF dbo.fn_ProfesorPuedeGestionarAsignatura(
            TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT),
            @codigo_interno_asignatura) = 0
    BEGIN
        RAISERROR('Error: El profesor solo puede registrar notas de sus asignaturas.', 16, 1);
        RETURN;
    END

    UPDATE NotaFinal
    SET promedio_final = @promedio_final,
        estado_nota = @estado_nota
    WHERE id_estudiante = @id_estudiante
      AND codigo_interno_asignatura = @codigo_interno_asignatura;
END
GO

--Obtener una nota final
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotaFinal_Obtener
    @id_nota_final INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM NotaFinal WHERE id_nota_final = @id_nota_final)
    BEGIN
        RAISERROR('Error: La nota final con ID %d no existe.', 16, 1, @id_nota_final);
        RETURN;
    END
    SELECT nf.id_nota_final, nf.promedio_final, nf.estado_nota, nf.id_estudiante,
           nf.codigo_interno_asignatura, e.cedula_estudiante, a.nombre_asignatura
    FROM NotaFinal nf
    JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    JOIN Asignatura a ON a.codigo_interno_asignatura = nf.codigo_interno_asignatura
    WHERE nf.id_nota_final = @id_nota_final;
END
GO

--Eliminar una nota final
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotaFinal_Eliminar
    @id_nota_final INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM NotaFinal WHERE id_nota_final = @id_nota_final)
    BEGIN
        RAISERROR('Error: La nota final con ID %d no existe.', 16, 1, @id_nota_final);
        RETURN;
    END
    DELETE FROM NotaFinal WHERE id_nota_final = @id_nota_final;
END
GO

-- CRUD: ASISTENCIA
USE InstitutoTECNIC;
GO
--Crear una asistencia
CREATE PROCEDURE sp_Asistencia_Insertar
    @id_estudiante             INT,
    @codigo_interno_asignatura INT,
    @estado_asistencia         VARCHAR(15) = 'Presente',
    @fecha_asistencia          DATE = NULL,
    @justificacion             VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET @fecha_asistencia = COALESCE(@fecha_asistencia, CAST(GETDATE() AS DATE));

    IF @estado_asistencia NOT IN ('Presente', 'Ausente', 'Tardía', 'Justificada')
    BEGIN
        RAISERROR('Error: Estado de asistencia no valido.', 16, 1);
        RETURN;
    END
    IF @estado_asistencia = 'Justificada' AND (@justificacion IS NULL OR LEN(RTRIM(@justificacion)) = 0)
    BEGIN
        RAISERROR('Error: La asistencia justificada requiere una justificacion.', 16, 1);
        RETURN;
    END
    IF @fecha_asistencia > CAST(GETDATE() AS DATE)
    BEGIN
        RAISERROR('Error: No se puede registrar asistencia en una fecha futura.', 16, 1);
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
    IF dbo.fn_ProfesorPuedeGestionarAsignatura(
            TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT),
            @codigo_interno_asignatura) = 0
    BEGIN
        RAISERROR('Error: El profesor solo puede registrar asistencia de sus asignaturas.', 16, 1);
        RETURN;
    END
    INSERT INTO Asistencia (fecha_asistencia, estado_asistencia, justificacion, id_estudiante, codigo_interno_asignatura)
    VALUES (@fecha_asistencia, @estado_asistencia, @justificacion, @id_estudiante, @codigo_interno_asignatura);
    SELECT SCOPE_IDENTITY() AS id_asistencia_creada;
END
GO

--Obtener una asistencia
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asistencia_Obtener
    @id_asistencia INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asistencia WHERE id_asistencia = @id_asistencia)
    BEGIN
        RAISERROR('Error: La asistencia con ID %d no existe.', 16, 1, @id_asistencia);
        RETURN;
    END
    SELECT a.id_asistencia, a.fecha_asistencia, a.estado_asistencia, a.justificacion,
           a.id_estudiante, a.codigo_interno_asignatura, e.cedula_estudiante, asig.nombre_asignatura
    FROM Asistencia a
    JOIN Estudiante e ON e.id_estudiante = a.id_estudiante
    JOIN Asignatura asig ON asig.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE a.id_asistencia = @id_asistencia;
END
GO

--Actualizar una asistencia
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asistencia_Actualizar
    @id_asistencia     INT,
    @estado_asistencia VARCHAR(15),
    @justificacion     VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asistencia WHERE id_asistencia = @id_asistencia)
    BEGIN
        RAISERROR('Error: La asistencia con ID %d no existe.', 16, 1, @id_asistencia);
        RETURN;
    END
    IF @estado_asistencia NOT IN ('Presente', 'Ausente', 'Tardía', 'Justificada')
    BEGIN
        RAISERROR('Error: Estado de asistencia no valido.', 16, 1);
        RETURN;
    END
    IF @estado_asistencia = 'Justificada' AND (@justificacion IS NULL OR LEN(RTRIM(@justificacion)) = 0)
    BEGIN
        RAISERROR('Error: La asistencia justificada requiere una justificacion.', 16, 1);
        RETURN;
    END
    UPDATE Asistencia
       SET estado_asistencia = @estado_asistencia,
           justificacion = @justificacion
     WHERE id_asistencia = @id_asistencia;
END
GO

--Eliminar una asistencia
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Asistencia_Eliminar
    @id_asistencia INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asistencia WHERE id_asistencia = @id_asistencia)
    BEGIN
        RAISERROR('Error: La asistencia con ID %d no existe.', 16, 1, @id_asistencia);
        RETURN;
    END
    DELETE FROM Asistencia WHERE id_asistencia = @id_asistencia;
END
GO
--Consultas JOIN
USE InstitutoTECNIC;
GO
--Consultar la antiguedad de un tutor
CREATE FUNCTION dbo.fn_AntiguedadTutorDesglose
(
    @fecha_inicio DATE,
    @fecha_fin    DATE,
    @fecha_corte  DATE
)
RETURNS @Desglose TABLE
(
    meses_totales INT NOT NULL,
    anios         INT NOT NULL,
    meses         INT NOT NULL,
    dias          INT NOT NULL
)
AS
BEGIN
    DECLARE @fin_efectiva  DATE;
    DECLARE @meses_totales INT = 0;
    DECLARE @dias          INT = 0;

    IF @fecha_inicio IS NULL OR @fecha_corte < @fecha_inicio
    BEGIN
        INSERT INTO @Desglose (meses_totales, anios, meses, dias)
        VALUES (0, 0, 0, 0);
        RETURN;
    END

    SET @fin_efectiva = COALESCE(@fecha_fin, @fecha_corte);

    IF @fin_efectiva < @fecha_inicio
    BEGIN
        INSERT INTO @Desglose (meses_totales, anios, meses, dias)
        VALUES (0, 0, 0, 0);
        RETURN;
    END

    SET @meses_totales = DATEDIFF(MONTH, @fecha_inicio, DATEADD(DAY, 1, @fin_efectiva));
    SET @dias = DATEDIFF(DAY, DATEADD(MONTH, @meses_totales, @fecha_inicio), @fin_efectiva);

    IF @dias < 0
        SET @dias = 0;

    INSERT INTO @Desglose (meses_totales, anios, meses, dias)
    VALUES (@meses_totales, @meses_totales / 12, @meses_totales % 12, @dias);

    RETURN;
END
GO

USE InstitutoTECNIC;
GO
--Actualizar la antiguedad de un tutor
CREATE PROCEDURE sp_Tutoria_ActualizarAntiguedad
    @id_tutoria INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    UPDATE t
    SET antiguedad_tutor = d.anios
    FROM Tutoria t
    CROSS APPLY dbo.fn_AntiguedadTutorDesglose(
        t.fecha_inicio_tutoria, t.fecha_fin_tutoria, @hoy
    ) d
    WHERE t.fecha_inicio_tutoria IS NOT NULL
      AND (@id_tutoria IS NULL OR t.id_tutoria = @id_tutoria);
END
GO

-- CRUD: TUTORIA
USE InstitutoTECNIC;
GO
--Crear una tutoria
CREATE PROCEDURE sp_Tutoria_Insertar
    @codigo_interno_profesor INT,
    @id_curso                INT,
    @fecha_inicio_tutoria    DATE,
    @fecha_fin_tutoria       DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @id_nuevo INT;

    IF NOT EXISTS (SELECT 1 FROM Profesor WHERE codigo_interno_profesor = @codigo_interno_profesor)
       OR NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso)
    BEGIN
        RAISERROR('Error: Profesor o curso no existe.', 16, 1);
        RETURN;
    END
    IF @fecha_inicio_tutoria IS NULL
    BEGIN
        RAISERROR('Error: Debe indicar la fecha de inicio de la tutoria.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM Tutoria WHERE id_curso = @id_curso AND fecha_fin_tutoria IS NULL)
    BEGIN
        RAISERROR('Error: El curso ya tiene un tutor activo.', 16, 1);
        RETURN;
    END
    INSERT INTO Tutoria (antiguedad_tutor, fecha_inicio_tutoria, fecha_fin_tutoria,
                         codigo_interno_profesor, id_curso)
    VALUES (0, @fecha_inicio_tutoria, @fecha_fin_tutoria,
            @codigo_interno_profesor, @id_curso);

    SET @id_nuevo = SCOPE_IDENTITY();

    EXEC sp_Tutoria_ActualizarAntiguedad @id_tutoria = @id_nuevo;

    SELECT @id_nuevo AS id_tutoria_creada;
END
GO

--Obtener una tutoria
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Tutoria_Obtener
    @id_tutoria INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tutoria WHERE id_tutoria = @id_tutoria)
    BEGIN
        RAISERROR('Error: La tutoria con ID %d no existe.', 16, 1, @id_tutoria);
        RETURN;
    END
    SELECT t.id_tutoria, t.antiguedad_tutor, t.fecha_inicio_tutoria, t.fecha_fin_tutoria,
           t.codigo_interno_profesor, t.id_curso, p.nombre_profesor, c.nivel_curso
    FROM Tutoria t
    JOIN Profesor p ON p.codigo_interno_profesor = t.codigo_interno_profesor
    JOIN Curso c ON c.id_curso = t.id_curso
    WHERE t.id_tutoria = @id_tutoria;
END
GO

--Actualizar una tutoria
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Tutoria_Actualizar
    @id_tutoria           INT,
    @fecha_inicio_tutoria DATE,
    @fecha_fin_tutoria    DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tutoria WHERE id_tutoria = @id_tutoria)
    BEGIN
        RAISERROR('Error: La tutoria con ID %d no existe.', 16, 1, @id_tutoria);
        RETURN;
    END
    IF @fecha_fin_tutoria IS NOT NULL AND @fecha_fin_tutoria < @fecha_inicio_tutoria
    BEGIN
        RAISERROR('Error: La fecha fin no puede ser anterior a la fecha inicio.', 16, 1);
        RETURN;
    END
    UPDATE Tutoria
       SET fecha_inicio_tutoria = @fecha_inicio_tutoria,
           fecha_fin_tutoria = @fecha_fin_tutoria
     WHERE id_tutoria = @id_tutoria;
    EXEC sp_Tutoria_ActualizarAntiguedad @id_tutoria = @id_tutoria;
END
GO

--Eliminar una tutoria
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Tutoria_Eliminar
    @id_tutoria INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Tutoria WHERE id_tutoria = @id_tutoria)
    BEGIN
        RAISERROR('Error: La tutoria con ID %d no existe.', 16, 1, @id_tutoria);
        RETURN;
    END
    DELETE FROM Tutoria WHERE id_tutoria = @id_tutoria;
END
GO

-- Soporte bitacora (requerido por triggers del script 5)
--Registrar en bitacora
USE InstitutoTECNIC;
GO
CREATE PROCEDURE dbo.sp_Bitacora_Registrar
    @operacion VARCHAR(10),
    @tabla     VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL
        SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = 'Administrador';

    IF @u IS NULL
        RETURN;

    INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
    VALUES (
        @u,
        LEFT(CONCAT(@operacion, ' en ', @tabla), 200),
        CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address'))
    );
END
GO