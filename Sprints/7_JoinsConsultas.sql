/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 7/7
   JOINS Y CONSULTAS DEL ENUNCIADO (EJECUCION)
   Los procedimientos estan definidos en 3_CRUDyProcedimientos.sql
   ============================================================================ */

USE InstitutoTECNIC;
GO
EXEC sp_Join_Inner_ProfesorAsignatura;
GO
EXEC sp_Join_Left_AsignaturaPrerrequisito;
GO
EXEC sp_Join_Right_AsignaturaMatricula;
GO
EXEC sp_Join_Full_EstudianteMatricula;
GO
EXEC sp_Join_Cross_ProfesorAula;
GO
EXEC sp_Join_AsignaturaPrerrequisito;
GO
EXEC sp_Join_LeftExclusive_SinPrerrequisito;
GO
EXEC sp_Join_RightExclusive_SinMatricula;
GO
EXEC sp_AsignaturasPorBloque @dia_semana = 'Lunes', @num_bloque = 1, @id_periodo = 3;
GO
EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = 13;
GO
EXEC sp_AsignaturasConPrerrequisitos;
GO
EXEC sp_AulasVacias @dia_semana = 'Lunes', @num_bloque = 1, @id_periodo = 3;
GO
EXEC sp_AsignaturasPorCicloCurso @codigo_interno_ciclo = 4, @id_curso = 7;
GO
EXEC sp_HorarioCompleto @id_periodo = 3;
GO
EXEC sp_AsignaturasPorEstudiante @id_estudiante = 1;
GO
EXEC sp_TutoresPorCurso;
GO
EXEC sp_ResumenAsistenciaEstudiante @id_estudiante = 2;
GO
EXEC sp_NotasFinalesPorEstudiante @id_estudiante = 1;
GO
EXEC sp_ResumenNotasEstudiante @id_estudiante = 1;
GO
EXEC sp_AsignaturasPorPeriodo @id_periodo = 3;
GO
EXEC sp_EstudiantesPorAsignatura @codigo_interno_asignatura = 13;
GO
EXEC sp_NotasPorPeriodo @id_periodo = 3;
GO
