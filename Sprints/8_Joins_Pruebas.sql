/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 8/11
   PRUEBAS DE CONSULTAS CON JOINS
   ============================================================================ */

-- CONSULTAS DEL ENUNCIADO

-- Que asignaturas se imparten en un bloque horario determinado
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorBloque @dia_semana = 'Lunes', @num_bloque = 1, @id_periodo = 3;
GO

-- Que profesor imparte determinada asignatura
USE InstitutoTECNIC;
GO
EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = 13;
GO

-- Que asignaturas requieren prerrequisitos
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasConPrerrequisitos;
GO

-- Que aulas estan vacias en un dia y bloque especifico
USE InstitutoTECNIC;
GO
EXEC sp_AulasVacias @dia_semana = 'Lunes', @num_bloque = 1, @id_periodo = 3;
GO

-- Que asignaturas se imparten en un ciclo especifico y curso determinado
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorCicloCurso @codigo_interno_ciclo = 4, @id_curso = 7;
GO


-- OTRAS CONSULTAS

-- Horario completo del instituto (filtrable por periodo)
USE InstitutoTECNIC;
GO
EXEC sp_HorarioCompleto @id_periodo = 3;
GO

-- Asignaturas en las que esta matriculado un estudiante (matricula activa)
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorEstudiante @id_estudiante = 1;
GO

-- Tutores vigentes por curso y ciclo con su antiguedad como tutor
USE InstitutoTECNIC;
GO
EXEC sp_TutoresPorCurso;
GO

-- Resumen de asistencia de un estudiante por asignatura (presente, ausente, etc.)
USE InstitutoTECNIC;
GO
EXEC sp_ResumenAsistenciaEstudiante @id_estudiante = 2;
GO

-- Notas finales de un estudiante en todas sus asignaturas
USE InstitutoTECNIC;
GO
EXEC sp_NotasFinalesPorEstudiante @id_estudiante = 1;
GO

-- Resumen de notas de un estudiante (aprobadas, reprobadas, en curso, promedio)
USE InstitutoTECNIC;
GO
EXEC sp_ResumenNotasEstudiante @id_estudiante = 1;
GO

-- Todas las asignaturas ofertadas en un periodo con profesor y aula
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturasPorPeriodo @id_periodo = 3;
GO

-- Estudiantes matriculados en una asignatura con estado de nota
USE InstitutoTECNIC;
GO
EXEC sp_EstudiantesPorAsignatura @codigo_interno_asignatura = 13;
GO

-- Notas finales de todos los estudiantes en un periodo
USE InstitutoTECNIC;
GO
EXEC sp_NotasPorPeriodo @id_periodo = 3;
GO

-- Antiguedad actual en anos, meses y dias + detalle historico por cada semestre impartido
USE InstitutoTECNIC;
GO
EXEC sp_ProfesorAsignatura_ConsultarAntiguedad @codigo_interno_profesor = 4, @codigo_oficial = 'CON-101';
GO

-- INNER JOIN: profesores con asignaturas vigentes (sin fecha_fin) y su antiguedad
USE InstitutoTECNIC;
GO
EXEC sp_Join_Inner_ProfesorAsignatura;
GO

-- LEFT JOIN: todas las asignaturas y, si tiene, sus prerrequisitos
USE InstitutoTECNIC;
GO
EXEC sp_Join_Left_AsignaturaPrerrequisito;
GO

-- RIGHT JOIN: todas las asignaturas y las matriculas asociadas (si existen)
USE InstitutoTECNIC;
GO
EXEC sp_Join_Right_AsignaturaMatricula;
GO

-- FULL JOIN: estudiantes y matriculas (incluye quien no tiene matricula y viceversa)
USE InstitutoTECNIC;
GO
EXEC sp_Join_Full_EstudianteMatricula;
GO

-- CROSS JOIN: todas las combinaciones posibles entre profesores y aulas
USE InstitutoTECNIC;
GO
EXEC sp_Join_Cross_ProfesorAula;
GO

-- INNER JOIN: asignaturas que tienen prerrequisitos y cuales son
USE InstitutoTECNIC;
GO
EXEC sp_Join_AsignaturaPrerrequisito;
GO

-- LEFT JOIN exclusivo: asignaturas que NO tienen ningun prerrequisito
USE InstitutoTECNIC;
GO
EXEC sp_Join_LeftExclusive_SinPrerrequisito;
GO

-- RIGHT JOIN exclusivo: estudiantes que NO tienen matricula registrada
USE InstitutoTECNIC;
GO
EXEC sp_Join_RightExclusive_SinMatricula;
GO
