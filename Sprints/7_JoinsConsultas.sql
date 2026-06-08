/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 7/7
   JOINS Y CONSULTAS DEL ENUNCIADO
   ============================================================================ */

-- INNER JOIN: profesores y las asignaturas que imparten (activas)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Inner_ProfesorAsignatura
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

-- LEFT JOIN: todas las asignaturas, tengan o no prerrequisito
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Left_AsignaturaPrerrequisito
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

-- RIGHT JOIN: asignaturas vistas desde la matricula
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Right_AsignaturaMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT am.id_matricula, a.nombre_asignatura AS asignatura
    FROM AsignaturaMatricula am
    RIGHT JOIN Asignatura a ON a.codigo_interno_asignatura = am.codigo_interno_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

-- FULL JOIN: estudiantes y matriculas
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Full_EstudianteMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante AS estudiante, m.id_matricula, m.fecha_matricula, m.estado_matricula
    FROM Estudiante e
    FULL JOIN Matricula m ON e.id_estudiante = m.id_estudiante;
END
GO

-- CROSS JOIN: profesores y aulas
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

-- SELF JOIN: asignatura con su prerrequisito por codigo oficial
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_Self_Prerrequisito
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

-- LEFT EXCLUSIVE JOIN: asignaturas sin prerrequisitos
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_Join_LeftExclusive_SinPrerrequisito
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

-- 1) Asignaturas en un bloque horario determinado
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorBloque
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

-- 2) Profesor que imparte una asignatura (activo)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ProfesorDeAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.codigo_interno_profesor, p.nombre_profesor, p.apellido1_profesor,
           p.correo_profesor, p.telefono_profesor,
           a.fecha_inicio_imparticion_profe, a.antiguedad_profesor AS antiguedad_anios
    FROM Asignatura a
    JOIN Profesor p ON p.codigo_interno_profesor = a.codigo_interno_profesor
    WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura
      AND a.fecha_fin_imparticion_profe IS NULL;
END
GO

-- 3) Asignaturas con prerrequisitos
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasConPrerrequisitos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura, a.nombre_asignatura AS asignatura,
           COUNT(ap.id_asignatura_prerrequisito) AS cantidad_prerrequisitos,
           STRING_AGG(pr.nombre_asignatura_prerequisito, ', ') AS lista_prerrequisitos
    FROM Asignatura a
    JOIN AsignaturaPrerrequisito ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito
    WHERE pr.estado_prerrequisito = N'Activo'
    GROUP BY a.codigo_interno_asignatura, a.nombre_asignatura
    ORDER BY a.nombre_asignatura;
END
GO

-- 4) Aulas vacias en un dia y bloque
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AulasVacias
    @dia_semana NVARCHAR(15),
    @num_bloque INT
AS
BEGIN
    SET NOCOUNT ON;
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

-- 5) Asignaturas por ciclo y curso
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorCicloCurso
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

-- Horario completo
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_HorarioCompleto
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

-- Asignaturas de un estudiante (matricula activa)
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_AsignaturasPorEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, a.nombre_asignatura, m.fecha_matricula
    FROM AsignaturaMatricula am
    JOIN Matricula m ON am.id_matricula = m.id_matricula
    JOIN Estudiante e ON m.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON am.codigo_interno_asignatura = a.codigo_interno_asignatura
    WHERE m.id_estudiante = @id_estudiante AND m.estado_matricula = N'Activa'
    ORDER BY a.nombre_asignatura;
END
GO

-- Tutores por curso
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_TutoresPorCurso
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

-- Resumen de asistencia
USE InstitutoTECNIC;
GO
CREATE OR ALTER PROCEDURE sp_ResumenAsistenciaEstudiante
    @id_estudiante INT,
    @fecha_desde DATETIME = NULL,
    @fecha_hasta DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante, a.nombre_asignatura,
           COUNT(CASE WHEN asis.estado_asistencia = N'Presente' THEN 1 END) AS presentes,
           COUNT(CASE WHEN asis.estado_asistencia = N'Ausente' THEN 1 END) AS ausentes,
           COUNT(CASE WHEN asis.estado_asistencia = N'Tardía' THEN 1 END) AS tardias,
           COUNT(CASE WHEN asis.estado_asistencia = N'Justificada' THEN 1 END) AS justificadas,
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

-- DEMOSTRACION
USE InstitutoTECNIC;
GO
EXEC sp_Join_Inner_ProfesorAsignatura;
GO
EXEC sp_Join_Left_AsignaturaPrerrequisito;
GO
EXEC sp_Join_Self_Prerrequisito;
GO
EXEC sp_AsignaturasPorBloque @dia_semana = N'Lunes', @num_bloque = 1;
GO
EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = 4;
GO
EXEC sp_AsignaturasConPrerrequisitos;
GO
EXEC sp_AulasVacias @dia_semana = N'Lunes', @num_bloque = 1;
GO
EXEC sp_AsignaturasPorCicloCurso @codigo_interno_ciclo = 4, @id_curso = 7;
GO
EXEC sp_HorarioCompleto;
GO
EXEC sp_AsignaturasPorEstudiante @id_estudiante = 1;
GO
EXEC sp_TutoresPorCurso;
GO
EXEC sp_ResumenAsistenciaEstudiante @id_estudiante = 2;
GO
