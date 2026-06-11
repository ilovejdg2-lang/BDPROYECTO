/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 4/11
   PROCEDIMIENTOS ESPECIALES Y CONSULTAS
   ============================================================================ */

--Consultar asignaturas por bloque horario
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorBloque
    @dia_semana VARCHAR(15),
    @num_bloque INT,
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: Dia o bloque no valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo no existe.', 16, 1);
        RETURN;
    END
    SELECT pe.nombre_periodo AS periodo,
           pe.annio,
           h.dia_semana,
           h.num_bloque,
           bh.hora_inicio_bloque,
           bh.hora_fin_bloque,
           a.codigo_interno_asignatura,
           a.codigo_oficial,
           a.nombre_asignatura AS asignatura,
           p.nombre_profesor,
           p.apellido1_profesor,
           au.nombre_aula AS aula
    FROM Horario h
    INNER JOIN BloqueHorario bh ON bh.num_bloque = h.num_bloque
    INNER JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
    INNER JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN AsignaturaProfesor ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    INNER JOIN Profesor p ON ap.codigo_interno_profesor = p.codigo_interno_profesor
    INNER JOIN Aula au ON a.id_aula = au.id_aula
    WHERE h.dia_semana = @dia_semana
      AND h.num_bloque = @num_bloque
      AND a.id_periodo = @id_periodo
    ORDER BY a.nombre_asignatura;
END
GO

--Consultar profesor de una asignatura
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
    IF NOT EXISTS (
        SELECT 1 FROM AsignaturaProfesor
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura
    )
    BEGIN
        RAISERROR('Error: La asignatura no tiene profesor asignado.', 16, 1);
        RETURN;
    END
    SELECT a.nombre_asignatura AS asignatura,
           p.codigo_interno_profesor, p.nombre_profesor, p.apellido1_profesor,
           u.correo_usuario, p.telefono_profesor,
           ap.fecha_inicio_imparticion, ap.fecha_fin_imparticion
    FROM Asignatura a
    JOIN AsignaturaProfesor ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Profesor p ON p.codigo_interno_profesor = ap.codigo_interno_profesor
    LEFT JOIN Usuario u ON p.id_usuario = u.id_usuario
    WHERE a.codigo_interno_asignatura = @codigo_interno_asignatura;
END
GO

--Consultar asignaturas con prerrequisitos
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasConPrerrequisitos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT a.codigo_interno_asignatura,
           a.nombre_asignatura AS asignatura,
           pr.nombre_asignatura_prerequisito AS asignatura_prerrequisito,
           pr.codigo_oficial_asignatura_prerequerida AS codigo_oficial_prerrequisito
    FROM Asignatura a
    INNER JOIN AsignaturaPrerrequisito ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito
    WHERE pr.estado_prerrequisito = 'Activo'
    ORDER BY a.nombre_asignatura, pr.nombre_asignatura_prerequisito;
END
GO

--Consultar aulas vacias
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AulasVacias
    @dia_semana VARCHAR(15),
    @num_bloque INT,
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF @dia_semana NOT IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')
       OR @num_bloque NOT BETWEEN 1 AND 6
    BEGIN
        RAISERROR('Error: Dia o bloque no valido.', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo no existe.', 16, 1);
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
          AND a.id_periodo = @id_periodo
    )
    ORDER BY s.nombre_sede, au.numero_aula;
END
GO

--Consultar asignaturas por ciclo y curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorCicloCurso
    @codigo_interno_ciclo INT,
    @id_curso INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Ciclo WHERE codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El ciclo no existe.', 16, 1);
        RETURN;
    END
    IF @id_curso IS NOT NULL
       AND NOT EXISTS (SELECT 1 FROM Curso WHERE id_curso = @id_curso AND codigo_interno_ciclo = @codigo_interno_ciclo)
    BEGIN
        RAISERROR('Error: El curso no pertenece al ciclo indicado.', 16, 1);
        RETURN;
    END

    SELECT ci.nombre_ciclo AS ciclo,
           cu.nivel_curso AS curso,
           a.codigo_interno_asignatura,
           a.codigo_oficial,
           a.nombre_asignatura AS asignatura,
           a.duracion_horas_asignatura,
           p.nombre_profesor,
           p.apellido1_profesor
    FROM Asignatura a
    INNER JOIN AsignaturaCiclo acic ON acic.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN AsignaturaCurso acur ON acur.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN Curso cu ON cu.id_curso = acur.id_curso
    INNER JOIN Ciclo ci ON ci.codigo_interno_ciclo = acic.codigo_interno_ciclo
                        AND ci.codigo_interno_ciclo = cu.codigo_interno_ciclo
    INNER JOIN AsignaturaProfesor ap ON ap.codigo_interno_asignatura = a.codigo_interno_asignatura
    INNER JOIN Profesor p ON p.codigo_interno_profesor = ap.codigo_interno_profesor
    WHERE ci.codigo_interno_ciclo = @codigo_interno_ciclo
      AND (@id_curso IS NULL OR cu.id_curso = @id_curso)
    ORDER BY cu.nivel_curso, a.nombre_asignatura;
END
GO

--Consultar horario completo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_HorarioCompleto
    @id_periodo INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT pe.nombre_periodo AS periodo, pe.annio,
           h.dia_semana, h.num_bloque, bh.hora_inicio_bloque, bh.hora_fin_bloque,
           au.nombre_aula AS aula,
           p.nombre_profesor,
           p.apellido1_profesor,
           a.nombre_asignatura AS asignatura,
           cu.nivel_curso AS curso,
           ci.nombre_ciclo AS ciclo
    FROM Horario h
    JOIN BloqueHorario bh ON bh.num_bloque = h.num_bloque
    JOIN HorarioAsignatura ha ON h.id_horario = ha.id_horario
    JOIN Asignatura a ON ha.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN AsignaturaProfesor pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    JOIN Profesor p ON pa.codigo_interno_profesor = p.codigo_interno_profesor
    JOIN Aula au ON a.id_aula = au.id_aula
    LEFT JOIN AsignaturaCurso ac ON ac.codigo_interno_asignatura = a.codigo_interno_asignatura
    LEFT JOIN Curso cu ON ac.id_curso = cu.id_curso
    LEFT JOIN Ciclo ci ON cu.codigo_interno_ciclo = ci.codigo_interno_ciclo
    WHERE @id_periodo IS NULL OR a.id_periodo = @id_periodo
    ORDER BY pe.annio, pe.nombre_periodo, h.dia_semana, h.num_bloque;
END
GO

--Consultar asignaturas por estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante,
           e.apellido1_estudiante,
           s.nombre_sede AS sede_matricula,
           cu.nivel_curso AS curso,
           ci.nombre_ciclo AS ciclo,
           pe.nombre_periodo AS periodo, pe.annio,
           a.nombre_asignatura, m.fecha_matricula
    FROM AsignaturaMatricula am
    JOIN Matricula m ON am.id_matricula = m.id_matricula
    JOIN Sede s ON m.id_sede = s.id_sede
    JOIN Estudiante e ON m.id_estudiante = e.id_estudiante
    JOIN Asignatura a ON am.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    JOIN AsignaturaCurso ac ON ac.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Curso cu ON cu.id_curso = ac.id_curso
    JOIN Ciclo ci ON ci.codigo_interno_ciclo = cu.codigo_interno_ciclo
    WHERE m.id_estudiante = @id_estudiante AND m.estado_matricula = 'Activa'
    ORDER BY a.nombre_asignatura, cu.nivel_curso;
END
GO

--Consultar tutores por curso
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_TutoresPorCurso
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    SELECT p.nombre_profesor,
           p.apellido1_profesor,
           p.apellido2_profesor,
           cu.nivel_curso AS curso,
           ci.nombre_ciclo AS ciclo,
           t.fecha_inicio_tutoria,
           d.anios,
           d.meses,
           d.dias,
           dbo.fn_AntiguedadTexto(d.anios, d.meses, d.dias, 0) AS antiguedad_texto,
           t.antiguedad_tutor AS antiguedad_anios_registrada
    FROM Tutoria t
    INNER JOIN Profesor p ON t.codigo_interno_profesor = p.codigo_interno_profesor
    INNER JOIN Curso cu ON t.id_curso = cu.id_curso
    INNER JOIN Ciclo ci ON cu.codigo_interno_ciclo = ci.codigo_interno_ciclo
    CROSS APPLY dbo.fn_AntiguedadTutorDesglose(
        t.fecha_inicio_tutoria, t.fecha_fin_tutoria, @hoy
    ) d
    WHERE t.fecha_fin_tutoria IS NULL
    ORDER BY ci.nombre_ciclo, cu.nivel_curso;
END
GO

--Consultar resumen de asistencia por estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ResumenAsistenciaEstudiante
    @id_estudiante INT,
    @fecha_desde DATETIME = NULL,
    @fecha_hasta DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante,
           e.apellido1_estudiante,
           a.nombre_asignatura,
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
    GROUP BY e.nombre_estudiante, e.apellido1_estudiante, a.nombre_asignatura;
END
GO

--Consultar notas finales por estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotasFinalesPorEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante no existe.', 16, 1);
        RETURN;
    END
    SELECT e.nombre_estudiante,
           e.apellido1_estudiante,
           pe.nombre_periodo AS periodo,
           pe.annio,
           a.codigo_oficial,
           a.nombre_asignatura AS asignatura,
           nf.promedio_final,
           nf.estado_nota
    FROM NotaFinal nf
    JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    JOIN Asignatura a ON a.codigo_interno_asignatura = nf.codigo_interno_asignatura
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    WHERE nf.id_estudiante = @id_estudiante
    ORDER BY pe.annio, pe.nombre_periodo, a.nombre_asignatura;
END
GO

--Consultar asignaturas por periodo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_AsignaturasPorPeriodo
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo no existe.', 16, 1);
        RETURN;
    END
    SELECT pe.nombre_periodo AS periodo, pe.annio,
           a.codigo_interno_asignatura,
           a.codigo_oficial,
           a.nombre_asignatura AS asignatura,
           p.nombre_profesor,
           p.apellido1_profesor,
           au.nombre_aula AS aula
    FROM Asignatura a
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    JOIN AsignaturaProfesor pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
    JOIN Profesor p ON p.codigo_interno_profesor = pa.codigo_interno_profesor
    JOIN Aula au ON au.id_aula = a.id_aula
    WHERE a.id_periodo = @id_periodo
    ORDER BY a.nombre_asignatura;
END
GO

--Consultar estudiantes por asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_EstudiantesPorAsignatura
    @codigo_interno_asignatura INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Asignatura WHERE codigo_interno_asignatura = @codigo_interno_asignatura)
    BEGIN
        RAISERROR('Error: La asignatura no existe.', 16, 1);
        RETURN;
    END
    SELECT a.nombre_asignatura AS asignatura,
           pe.nombre_periodo AS periodo,
           e.nombre_estudiante,
           e.apellido1_estudiante,
           m.estado_matricula,
           s.nombre_sede AS sede,
           nf.estado_nota, nf.promedio_final
    FROM AsignaturaMatricula am
    JOIN Matricula m ON m.id_matricula = am.id_matricula
    JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    JOIN Sede s ON s.id_sede = m.id_sede
    JOIN Asignatura a ON a.codigo_interno_asignatura = am.codigo_interno_asignatura
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    LEFT JOIN NotaFinal nf ON nf.id_estudiante = e.id_estudiante
                          AND nf.codigo_interno_asignatura = am.codigo_interno_asignatura
    WHERE am.codigo_interno_asignatura = @codigo_interno_asignatura
    ORDER BY e.nombre_estudiante;
END
GO

--Consultar resumen de notas por estudiante
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ResumenNotasEstudiante
    @id_estudiante INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Estudiante WHERE id_estudiante = @id_estudiante)
    BEGIN
        RAISERROR('Error: El estudiante no existe.', 16, 1);
        RETURN;
    END
        SELECT e.nombre_estudiante,
            e.apellido1_estudiante,
            COUNT(CASE WHEN nf.estado_nota = 'Aprobado' THEN 1 END) AS aprobadas,
            COUNT(CASE WHEN nf.estado_nota = 'Reprobado' THEN 1 END) AS reprobadas,
            COUNT(CASE WHEN nf.estado_nota = 'En curso' THEN 1 END) AS en_curso,
            pa.promedio_aprobadas
        FROM Estudiante e
        LEFT JOIN NotaFinal nf ON nf.id_estudiante = e.id_estudiante
        OUTER APPLY (
         SELECT AVG(nf_aprobadas.promedio_final) AS promedio_aprobadas
         FROM NotaFinal nf_aprobadas
         WHERE nf_aprobadas.id_estudiante = e.id_estudiante
           AND nf_aprobadas.estado_nota = 'Aprobado'
           AND nf_aprobadas.promedio_final IS NOT NULL
        ) pa
        WHERE e.id_estudiante = @id_estudiante
        GROUP BY e.nombre_estudiante, e.apellido1_estudiante, pa.promedio_aprobadas;
END
GO

--Consultar notas por periodo
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_NotasPorPeriodo
    @id_periodo INT
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1 FROM Periodo WHERE id_periodo = @id_periodo)
    BEGIN
        RAISERROR('Error: El periodo no existe.', 16, 1);
        RETURN;
    END
    SELECT pe.nombre_periodo AS periodo,
           e.nombre_estudiante,
           e.apellido1_estudiante,
           a.nombre_asignatura AS asignatura,
           nf.promedio_final,
           nf.estado_nota
    FROM NotaFinal nf
    JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    JOIN Asignatura a ON a.codigo_interno_asignatura = nf.codigo_interno_asignatura
    JOIN Periodo pe ON pe.id_periodo = a.id_periodo
    WHERE a.id_periodo = @id_periodo
    ORDER BY e.nombre_estudiante, a.nombre_asignatura;
END
GO

--Consultar la antiguedad de un profesor y su asignatura
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Inner_AsignaturaProfesor
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @hoy DATE = CAST(GETDATE() AS DATE);

    SELECT p.nombre_profesor,
           p.apellido1_profesor,
           a.nombre_asignatura AS asignatura,
           a.codigo_oficial,
           d.anios,
           d.meses,
           d.dias,
           d.horas,
           dbo.fn_AntiguedadTexto(d.anios, d.meses, d.dias, d.horas) AS antiguedad_texto,
           ap.antiguedad_profesor AS antiguedad_anios_registrada
    FROM Profesor p
    INNER JOIN AsignaturaProfesor ap ON ap.codigo_interno_profesor = p.codigo_interno_profesor
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ap.codigo_interno_asignatura
    CROSS APPLY dbo.fn_AntiguedadProfesorDesglose(
        p.codigo_interno_profesor, a.codigo_oficial, @hoy
    ) d
    WHERE ap.fecha_fin_imparticion IS NULL
    ORDER BY p.nombre_profesor;
END
GO

--Consultar las asignaturas y sus prerrequisitos
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

--Consultar las asignaturas y sus matriculas
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

--Consultar los estudiantes y sus matriculas
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Full_EstudianteMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante,
           e.apellido1_estudiante,
           m.id_matricula,
           m.fecha_matricula,
           m.estado_matricula
    FROM Estudiante e
    FULL JOIN Matricula m ON e.id_estudiante = m.id_estudiante;
END
GO

--Consultar profesores y aulas
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_Cross_ProfesorAula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.nombre_profesor,
           p.apellido1_profesor,
           a.nombre_aula AS aula
    FROM Profesor p
    CROSS JOIN Aula a;
END
GO

--Consultar asignatura y prerrequisito
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_AsignaturaPrerrequisito
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

--Consultar asignaturas sin prerrequisito
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

--Consultar estudiantes sin matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_Join_RightExclusive_SinMatricula
AS
BEGIN
    SET NOCOUNT ON;
    SELECT e.nombre_estudiante,
           e.apellido1_estudiante
    FROM Matricula m
    RIGHT JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE m.id_matricula IS NULL
    ORDER BY e.nombre_estudiante;
END
GO

--Ofertar asignatura en matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ProcesoMatricula_AdminOfertarAsignatura
    @codigo_oficial                 VARCHAR(20),
    @nombre_asignatura              VARCHAR(100),
    @duracion_horas_asignatura      INT,
    @id_aula                        INT,
    @id_periodo                     INT,
    @codigo_interno_profesor        INT,
    @id_curso                       INT,
    @codigo_interno_ciclo           INT,
    @fecha_inicio_imparticion_profe DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @codigo_interno_asignatura INT;

    IF EXISTS (
        SELECT 1 FROM Asignatura
        WHERE codigo_oficial = @codigo_oficial AND id_periodo = @id_periodo
    )
    BEGIN
        SELECT @codigo_interno_asignatura = codigo_interno_asignatura
        FROM Asignatura
        WHERE codigo_oficial = @codigo_oficial AND id_periodo = @id_periodo;
    END
    ELSE
    BEGIN
        EXEC sp_Asignatura_Insertar
            @codigo_oficial = @codigo_oficial,
            @nombre_asignatura = @nombre_asignatura,
            @duracion_horas_asignatura = @duracion_horas_asignatura,
            @id_aula = @id_aula,
            @id_periodo = @id_periodo,
            @codigo_interno_profesor = @codigo_interno_profesor,
            @fecha_inicio_imparticion_profe = @fecha_inicio_imparticion_profe;

        SELECT @codigo_interno_asignatura = codigo_interno_asignatura
        FROM Asignatura
        WHERE codigo_oficial = @codigo_oficial AND id_periodo = @id_periodo;
    END

    IF NOT EXISTS (
        SELECT 1 FROM AsignaturaCurso
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura AND id_curso = @id_curso
    )
        EXEC sp_AsignaturaCurso_Insertar
            @codigo_interno_asignatura = @codigo_interno_asignatura,
            @id_curso = @id_curso;

    IF NOT EXISTS (
        SELECT 1 FROM AsignaturaCiclo
        WHERE codigo_interno_asignatura = @codigo_interno_asignatura
          AND codigo_interno_ciclo = @codigo_interno_ciclo
    )
        EXEC sp_AsignaturaCiclo_Insertar
            @codigo_interno_asignatura = @codigo_interno_asignatura,
            @codigo_interno_ciclo = @codigo_interno_ciclo;

    SELECT @codigo_interno_asignatura AS codigo_interno_asignatura_ofertada,
           @codigo_oficial AS codigo_oficial,
           @nombre_asignatura AS nombre_asignatura;

    EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = @codigo_interno_asignatura;
END
GO

--Inscribir asignaturas en matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ProcesoMatricula_EstudianteInscribir
    @id_estudiante       INT,
    @id_sede             INT,
    @fecha_matricula     DATE,
    @codigo_oficial      VARCHAR(20),
    @id_periodo          INT,
    @finalizar_anterior  BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @codigo_interno_asignatura INT;
    DECLARE @id_matricula              INT;
    DECLARE @matricula_activa          INT;
    DECLARE @id_usuario_sesion         INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    DECLARE @id_estudiante_sesion      INT;
    DECLARE @rol_sesion                VARCHAR(25);

    IF @id_usuario_sesion IS NOT NULL
    BEGIN
        SELECT @rol_sesion = rol FROM Usuario WHERE id_usuario = @id_usuario_sesion;

        IF @rol_sesion = 'Estudiante'
        BEGIN
            SELECT @id_estudiante_sesion = id_estudiante
            FROM Estudiante
            WHERE id_usuario = @id_usuario_sesion;

            IF @id_estudiante_sesion IS NULL
            BEGIN
                RAISERROR('Error: El usuario de estudiante no esta vinculado a un registro academico.', 16, 1);
                RETURN;
            END

            IF @id_estudiante <> @id_estudiante_sesion
            BEGIN
                RAISERROR('Error: Un estudiante solo puede matricularse a si mismo.', 16, 1);
                RETURN;
            END
        END
    END

    SELECT @codigo_interno_asignatura = codigo_interno_asignatura
    FROM Asignatura
    WHERE codigo_oficial = @codigo_oficial AND id_periodo = @id_periodo;

    IF @codigo_interno_asignatura IS NULL
    BEGIN
        RAISERROR('Error: La asignatura ofertada no existe para ese periodo.', 16, 1);
        RETURN;
    END

    SELECT @matricula_activa = id_matricula
    FROM Matricula
    WHERE id_estudiante = @id_estudiante AND estado_matricula = 'Activa';

    IF @matricula_activa IS NOT NULL
       AND @finalizar_anterior = 0
       AND YEAR(@fecha_matricula) <> (
           SELECT YEAR(fecha_matricula) FROM Matricula WHERE id_matricula = @matricula_activa
       )
    BEGIN
        RAISERROR('Error: Debe finalizar la matricula activa antes de matricular un nuevo annio.', 16, 1);
        RETURN;
    END

    IF @finalizar_anterior = 1 AND @matricula_activa IS NOT NULL
        EXEC sp_Matricula_Finalizar @id_matricula = @matricula_activa;

    IF EXISTS (
        SELECT 1 FROM Matricula
        WHERE id_estudiante = @id_estudiante AND estado_matricula = 'Activa'
    )
    BEGIN
        SELECT @id_matricula = id_matricula
        FROM Matricula
        WHERE id_estudiante = @id_estudiante AND estado_matricula = 'Activa';
    END
    ELSE
    BEGIN
        EXEC sp_Matricula_Insertar
            @id_estudiante = @id_estudiante,
            @id_sede = @id_sede,
            @fecha_matricula = @fecha_matricula,
            @estado_matricula = 'Activa';

        SELECT @id_matricula = id_matricula
        FROM Matricula
        WHERE id_estudiante = @id_estudiante AND estado_matricula = 'Activa';
    END

    IF NOT EXISTS (
        SELECT 1 FROM AsignaturaMatricula
        WHERE id_matricula = @id_matricula
          AND codigo_interno_asignatura = @codigo_interno_asignatura
    )
        EXEC sp_AsignaturaMatricula_Insertar
            @codigo_interno_asignatura = @codigo_interno_asignatura,
            @id_matricula = @id_matricula;

    SELECT @id_matricula AS id_matricula,
           @codigo_interno_asignatura AS codigo_interno_asignatura_inscrita,
           @codigo_oficial AS codigo_oficial;

    EXEC sp_AsignaturasPorEstudiante @id_estudiante = @id_estudiante;
END
GO

--Evaluar estudiante en matricula
USE InstitutoTECNIC;
GO
CREATE PROCEDURE sp_ProcesoMatricula_ProfesorEvaluarEstudiante
    @id_estudiante   INT,
    @codigo_oficial  VARCHAR(20),
    @id_periodo      INT,
    @asistencias     VARCHAR(MAX) = NULL,
    @promedio_final  DECIMAL(5,2) = NULL,
    @estado_nota     VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @codigo_interno_asignatura INT;
    DECLARE @registro                  VARCHAR(200);
    DECLARE @fecha_asistencia          DATE;
    DECLARE @estado_asistencia         VARCHAR(15);
    DECLARE @justificacion             VARCHAR(200);
    DECLARE @sep                       INT;
    DECLARE @sep2                      INT;

    SELECT @codigo_interno_asignatura = codigo_interno_asignatura
    FROM Asignatura
    WHERE codigo_oficial = @codigo_oficial AND id_periodo = @id_periodo;

    IF @codigo_interno_asignatura IS NULL
    BEGIN
        RAISERROR('Error: La asignatura no existe para ese periodo.', 16, 1);
        RETURN;
    END
    IF dbo.fn_ProfesorPuedeGestionarAsignatura(
            TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT),
            @codigo_interno_asignatura) = 0
    BEGIN
        RAISERROR('Error: El profesor solo puede evaluar estudiantes de sus asignaturas.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1 FROM NotaFinal
        WHERE id_estudiante = @id_estudiante
          AND codigo_interno_asignatura = @codigo_interno_asignatura
    )
        EXEC sp_NotaFinal_Insertar
            @estado_nota = 'En curso',
            @id_estudiante = @id_estudiante,
            @codigo_interno_asignatura = @codigo_interno_asignatura;

    IF @asistencias IS NOT NULL AND LEN(RTRIM(@asistencias)) > 0
    BEGIN
        DECLARE cur_asis CURSOR LOCAL FAST_FORWARD FOR
            SELECT LTRIM(RTRIM(value)) FROM STRING_SPLIT(@asistencias, ';')
            WHERE LEN(LTRIM(RTRIM(value))) > 0;

        OPEN cur_asis;
        FETCH NEXT FROM cur_asis INTO @registro;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @sep = CHARINDEX(':', @registro);
            SET @sep2 = CHARINDEX(':', @registro, @sep + 1);

            SET @fecha_asistencia = TRY_CAST(LEFT(@registro, @sep - 1) AS DATE);
            SET @estado_asistencia = LTRIM(RTRIM(SUBSTRING(@registro, @sep + 1,
                CASE WHEN @sep2 > 0 THEN @sep2 - @sep - 1 ELSE LEN(@registro) END)));

            SET @justificacion = CASE
                WHEN @sep2 > 0 THEN LTRIM(RTRIM(SUBSTRING(@registro, @sep2 + 1, LEN(@registro))))
                ELSE NULL
            END;

            EXEC sp_Asistencia_Insertar
                @id_estudiante = @id_estudiante,
                @codigo_interno_asignatura = @codigo_interno_asignatura,
                @estado_asistencia = @estado_asistencia,
                @fecha_asistencia = @fecha_asistencia,
                @justificacion = @justificacion;

            FETCH NEXT FROM cur_asis INTO @registro;
        END

        CLOSE cur_asis;
        DEALLOCATE cur_asis;

        EXEC sp_ResumenAsistenciaEstudiante @id_estudiante = @id_estudiante;
    END

    IF @promedio_final IS NOT NULL AND @estado_nota IS NOT NULL
        EXEC sp_NotaFinal_Actualizar
            @id_estudiante = @id_estudiante,
            @codigo_interno_asignatura = @codigo_interno_asignatura,
            @promedio_final = @promedio_final,
            @estado_nota = @estado_nota;

    EXEC sp_NotasFinalesPorEstudiante @id_estudiante = @id_estudiante;
END
GO

