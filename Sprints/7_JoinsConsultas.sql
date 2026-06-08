/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 7/7
   JOINS Y CONSULTAS DEL ENUNCIADO
   ============================================================================ */
-- A) TIPOS DE JOIN (cada uno dentro de un procedimiento)

-- INNER JOIN: profesores y las asignaturas que imparten (actualmente activos)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Inner_ProfesorAsignatura
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS profesor, a.nombre_asignatura AS asignatura, 
           pa.antiguedad_asignatura AS antiguedad_anios
    FROM Profesor p
    INNER JOIN ProfesorAsignatura pa ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura
    WHERE pa.fecha_fin IS NULL
    ORDER BY p.nombre_profesor;
END
GO

-- LEFT JOIN: todas las asignaturas, tengan o no prerrequisito
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Left_AsignaturaPrerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura, 
           ar.nombre_asignatura AS requiere_aprobar
    FROM Asignatura a
    LEFT JOIN Prerrequisito p ON a.codigo_interno_asignatura = p.codigo_interno_asignatura
    LEFT JOIN Asignatura ar ON ar.codigo_interno_asignatura = p.codigo_interno_asignatura_requerida
    ORDER BY a.nombre_asignatura;
END
GO

-- RIGHT JOIN: asignaturas vistas desde el detalle de matricula
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Right_DetalleAsignatura
AS
BEGIN
    SET NOCOUNT ON;
    SELECT d.id_matricula, a.nombre_asignatura AS asignatura
    FROM DetalleMatricula d
    RIGHT JOIN Asignatura a ON a.codigo_interno_asignatura = d.codigo_interno_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

-- FULL JOIN: estudiantes y matriculas (ambos lados completos)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Full_EstudianteMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante AS estudiante, m.id_matricula, m.periodo, m.estado
    FROM Estudiante e
    FULL JOIN Matricula m ON e.id_estudiante = m.id_estudiante;
END
GO

-- CROSS JOIN: todas las combinaciones posibles de profesor y aula
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Cross_ProfesorAula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS profesor, a.nombre_aula AS aula
    FROM Profesor p
    CROSS JOIN Aula a;
END
GO

-- SELF JOIN: cada asignatura junto con su asignatura requerida
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Self_Prerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura, 
           ar.nombre_asignatura AS asignatura_requerida
    FROM Prerrequisito pr
    JOIN Asignatura a ON a.codigo_interno_asignatura = pr.codigo_interno_asignatura
    JOIN Asignatura ar ON ar.codigo_interno_asignatura = pr.codigo_interno_asignatura_requerida;
END
GO

-- LEFT EXCLUSIVE JOIN: asignaturas que NO tienen prerrequisitos
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_LeftExclusive_SinPrerrequisito
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.nombre_asignatura AS asignatura
    FROM Asignatura a
    LEFT JOIN Prerrequisito p ON a.codigo_interno_asignatura = p.codigo_interno_asignatura
    WHERE p.id_prerrequisito IS NULL
    ORDER BY a.nombre_asignatura;
END
GO

-- RIGHT EXCLUSIVE JOIN: estudiantes sin matricula
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_RightExclusive_SinMatricula
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


-- FULL OUTER EXCLUSIVE JOIN: estudiantes sin matricula Y matriculas sin estudiante
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_FullOuterExclusive_SinRelacion
AS
BEGIN
    SET NOCOUNT ON;
    -- Estudiantes sin matricula
    SELECT e.nombre_estudiante AS nombre, 'Estudiante sin matricula' AS tipo
    FROM Estudiante e
    LEFT JOIN Matricula m ON e.id_estudiante = m.id_estudiante
    WHERE m.id_matricula IS NULL
    
    UNION
    
    -- Matriculas sin estudiante (no deberia ocurrir por FK, pero se incluye)
    SELECT CONCAT('Matricula ID: ', m.id_matricula) AS nombre, 'Matricula sin estudiante' AS tipo
    FROM Matricula m
    LEFT JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.id_estudiante IS NULL
    ORDER BY tipo, nombre;
END
GO
-- ============================================================================
-- B) CONSULTAS QUE PIDE EL ENUNCIADO DEL CASO
-- ============================================================================

-- 1) ¿Qué asignaturas se imparten en un bloque horario determinado?
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorBloque
    @dia_semana    NVARCHAR(15),
    @bloque        INT,
    @anio_academico INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @anio_academico IS NULL
        SET @anio_academico = YEAR(GETDATE());
    
    SELECT a.nombre_asignatura AS asignatura,
           p.nombre_profesor AS profesor,
           au.nombre_aula AS aula,
           h.dia_semana, h.bloque, h.anio_academico
    FROM Horario h
    JOIN ProfesorAsignatura pa ON h.id_profesor_asignatura = pa.id_profesor_asignatura
    JOIN Asignatura a ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula au ON h.numero_aula = au.numero_aula
    WHERE h.dia_semana = @dia_semana AND h.bloque = @bloque
      AND h.anio_academico = @anio_academico
    ORDER BY a.nombre_asignatura;
END
GO

-- 2) ¿Qué profesor imparte determinada asignatura? (actualmente)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorDeAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.codigo_interno_profesor, p.nombre_profesor, 
           p.correo_profesor, p.telefono_profesor,
           pa.fecha_inicio, pa.antiguedad_asignatura AS antiguedad_anios
    FROM ProfesorAsignatura pa
    JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    WHERE pa.codigo_interno_asignatura = @codigo_interno_asignatura
      AND pa.fecha_fin IS NULL;
END
GO

-- 2b) Historial de profesores que han impartido una asignatura
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_HistorialProfesoresAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor, pa.fecha_inicio, pa.fecha_fin,
           pa.antiguedad_asignatura AS antiguedad_anios,
           CASE WHEN pa.fecha_fin IS NULL THEN 'Activo' ELSE 'Inactivo' END AS estado
    FROM ProfesorAsignatura pa
    JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    WHERE pa.codigo_interno_asignatura = @codigo_interno_asignatura
    ORDER BY pa.fecha_inicio DESC;
END
GO

-- 3) ¿Qué asignaturas requieren prerrequisitos? (y cuántos)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasConPrerrequisitos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.nombre_asignatura AS asignatura,
           COUNT(pr.id_prerrequisito) AS cantidad_prerrequisitos,
           STRING_AGG(ar.nombre_asignatura, ', ') AS lista_prerrequisitos
    FROM Asignatura a
    JOIN Prerrequisito pr ON pr.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Asignatura ar ON ar.codigo_interno_asignatura = pr.codigo_interno_asignatura_requerida
    WHERE pr.estado = N'Activo'
    GROUP BY a.codigo_interno_asignatura, a.nombre_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

-- 4) ¿Qué aulas están vacías en un día y bloque específico?
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AulasVacias
    @dia_semana     NVARCHAR(15),
    @bloque         INT,
    @anio_academico INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @anio_academico IS NULL
        SET @anio_academico = YEAR(GETDATE());
    
    SELECT au.numero_aula, s.nombre_sede, au.nombre_aula, 
           au.capacidad, au.metros_cuadrados, au.tiene_proyector
    FROM Aula au
    JOIN Sede s ON au.id_sede = s.id_sede
    WHERE NOT EXISTS (
        SELECT 1 FROM Horario h
        WHERE h.numero_aula = au.numero_aula
          AND h.dia_semana = @dia_semana
          AND h.bloque = @bloque
          AND h.anio_academico = @anio_academico
    )
    ORDER BY s.nombre_sede, au.numero_aula;
END
GO

-- 5) ¿Qué asignaturas se imparten en un ciclo específico y curso determinado?
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorCicloCurso
    @codigo_interno_ciclo INT,
    @id_curso INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ci.nombre_ciclo AS ciclo, cu.nombre_curso AS curso, cu.nivel,
           a.codigo_interno_asignatura, a.codigo_oficial, 
           a.nombre_asignatura AS asignatura, a.duracion_horas,
           p.nombre_profesor AS profesor_titular
    FROM Asignatura a
    JOIN Curso cu ON cu.id_curso = a.id_curso
    JOIN Ciclo ci ON ci.codigo_interno_ciclo = cu.codigo_interno_ciclo
    LEFT JOIN ProfesorAsignatura pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura AND pa.fecha_fin IS NULL
    LEFT JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    WHERE ci.codigo_interno_ciclo = @codigo_interno_ciclo
      AND (@id_curso IS NULL OR cu.id_curso = @id_curso)
    ORDER BY cu.nivel, a.nombre_asignatura;
END
GO

-- ============================================================================
-- C) CONSULTAS ADICIONALES
-- ============================================================================

-- 6) Profesores y su historial
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_HistorialProfesores
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS profesor, a.nombre_asignatura AS asignatura,
           pa.fecha_inicio, pa.fecha_fin,
           CASE WHEN pa.fecha_fin IS NULL THEN 'Actualmente la da' 
                ELSE CONCAT('La dio de ', YEAR(pa.fecha_inicio), ' a ', YEAR(pa.fecha_fin)) 
           END AS periodo,
           pa.antiguedad_asignatura AS antiguedad_anios
    FROM ProfesorAsignatura pa
    JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura
    ORDER BY p.nombre_profesor, pa.fecha_inicio DESC;
END
GO

-- 7) Horario completo del año actual
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_HorarioCompleto
    @anio_academico INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF @anio_academico IS NULL
        SET @anio_academico = YEAR(GETDATE());
    
    SELECT h.dia_semana, h.bloque, a.nombre_aula AS aula,
           p.nombre_profesor AS profesor, asig.nombre_asignatura AS asignatura,
           c.nombre_curso AS curso, ci.nombre_ciclo AS ciclo
    FROM Horario h
    JOIN ProfesorAsignatura pa ON h.id_profesor_asignatura = pa.id_profesor_asignatura
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Asignatura asig ON pa.codigo_interno_asignatura = asig.codigo_interno_asignatura
    JOIN Aula a ON h.numero_aula = a.numero_aula
    JOIN Curso c ON h.id_curso = c.id_curso
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE h.anio_academico = @anio_academico
    ORDER BY 
        CASE h.dia_semana
            WHEN 'Lunes' THEN 1
            WHEN 'Martes' THEN 2
            WHEN 'Miércoles' THEN 3
            WHEN 'Jueves' THEN 4
            WHEN 'Viernes' THEN 5
            WHEN 'Sábado' THEN 6
        END, h.bloque;
END
GO

-- 8) Asignaturas que cursa un estudiante actualmente
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, a.nombre_asignatura, m.periodo
    FROM DetalleMatricula dm
    JOIN Matricula m ON dm.id_matricula = m.id_matricula
    JOIN Estudiante e ON m.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON dm.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE m.id_estudiante = @id_estudiante AND m.estado = N'Activa'
    ORDER BY a.nombre_asignatura;
END
GO

-- 9) Profesores que son tutores
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_TutoresPorCurso
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor AS tutor, c.nombre_curso AS curso,
           ci.nombre_ciclo AS ciclo, t.antiguedad_tutor AS antiguedad_anios,
           t.fecha_inicio_tutoria
    FROM Tutoria t
    JOIN Profesor p ON t.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Curso c ON t.id_curso = c.id_curso
    JOIN Ciclo ci ON c.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE t.fecha_fin_tutoria IS NULL
    ORDER BY ci.nombre_ciclo, c.nivel;
END
GO

-- 10) Resumen de asistencia de un estudiante
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ResumenAsistenciaEstudiante
    @id_estudiante INT,
    @fecha_desde DATE = NULL,
    @fecha_hasta DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, a.nombre_asignatura,
           COUNT(CASE WHEN asis.estado = N'Presente' THEN 1 END) AS presentes,
           COUNT(CASE WHEN asis.estado = N'Ausente' THEN 1 END) AS ausentes,
           COUNT(CASE WHEN asis.estado = N'Tardía' THEN 1 END) AS tardias,
           COUNT(CASE WHEN asis.estado = N'Justificada' THEN 1 END) AS justificadas,
           COUNT(*) AS total_clases
    FROM Asistencia asis
    JOIN Estudiante e ON asis.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON asis.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE asis.id_estudiante = @id_estudiante
      AND (@fecha_desde IS NULL OR asis.fecha >= @fecha_desde)
      AND (@fecha_hasta IS NULL OR asis.fecha <= @fecha_hasta)
    GROUP BY e.nombre_estudiante, a.nombre_asignatura;
END
GO

-- ============================================================================
-- D) EJECUCION DE DEMOSTRACION
-- ============================================================================

-- Joins
USE InstitutoTECNIC;
GO
EXEC sp_Join_Inner_ProfesorAsignatura;
GO

USE InstitutoTECNIC;
GO
EXEC sp_Join_Left_AsignaturaPrerrequisito;
GO

USE InstitutoTECNIC;
GO
EXEC sp_Join_Self_Prerrequisito;
GO

USE InstitutoTECNIC;
GO
EXEC sp_Join_LeftExclusive_SinPrerrequisito;
GO

-- Consultas del enunciado
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorBloque @dia_semana = N'Lunes', @bloque = 1;
GO

USE InstitutoTECNIC;
GO
EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = 4;
GO

USE InstitutoTECNIC;
GO
EXEC sp_HistorialProfesoresAsignatura @codigo_interno_asignatura = 3;
GO

USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasConPrerrequisitos;
GO

USE InstitutoTECNIC;
GO
EXEC sp_AulasVacias @dia_semana = N'Lunes', @bloque = 1;
GO

USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorCicloCurso @codigo_interno_ciclo = 4, @id_curso = 7;
GO

-- Consultas adicionales
USE InstitutoTECNIC;
GO
EXEC sp_HistorialProfesores;
GO

USE InstitutoTECNIC;
GO
EXEC sp_HorarioCompleto;
GO

USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorEstudiante @id_estudiante = 1;
GO

USE InstitutoTECNIC;
GO
EXEC sp_TutoresPorCurso;
GO

USE InstitutoTECNIC;
GO
EXEC sp_ResumenAsistenciaEstudiante @id_estudiante = 2;
GO