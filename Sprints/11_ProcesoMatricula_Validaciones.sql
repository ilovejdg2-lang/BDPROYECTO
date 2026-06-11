/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 11/11
   PROCESO DE MATRICULA (VALIDACIONES)
   ============================================================================ */

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'admin', @contrasena = 'Admin#2026';
GO

USE InstitutoTECNIC;
GO
EXEC sp_ProcesoMatricula_AdminOfertarAsignatura
    @codigo_oficial = 'DEMO-ERR-01',
    @nombre_asignatura = 'Asignatura Invalida',
    @duracion_horas_asignatura = 0,
    @id_aula = 3,
    @id_periodo = 7,
    @codigo_interno_profesor = 6,
    @id_curso = 7,
    @codigo_interno_ciclo = 4;
GO

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'yeisson.villalobos', @contrasena = 'Estu#2026';
GO

USE InstitutoTECNIC;
GO
EXEC sp_ProcesoMatricula_EstudianteInscribir
    @id_estudiante = 5,
    @id_sede = 1,
    @fecha_matricula = '2026-02-01',
    @codigo_oficial = 'DEMO-401',
    @id_periodo = 7,
    @finalizar_anterior = 0;
GO

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'sofia.mora', @contrasena = 'Profe#2026';
GO

USE InstitutoTECNIC;
GO
EXEC sp_ProcesoMatricula_ProfesorEvaluarEstudiante
    @id_estudiante = 5,
    @codigo_oficial = 'DEMO-401',
    @id_periodo = 7,
    @promedio_final = 65.00,
    @estado_nota = 'Aprobado';
GO
