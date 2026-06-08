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
EXEC sp_Join_Self_Prerrequisito;
GO
EXEC sp_AsignaturasPorBloque @dia_semana = 'Lunes', @num_bloque = 1;
GO
EXEC sp_ProfesorDeAsignatura @codigo_interno_asignatura = 4;
GO
EXEC sp_AsignaturasConPrerrequisitos;
GO
EXEC sp_AulasVacias @dia_semana = 'Lunes', @num_bloque = 1;
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
