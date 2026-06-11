/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 12/11
   PROCESO DE MATRICULA (VALIDACIONES)
   ============================================================================ */

-- Administrador: intentar ofertar una asignatura invalida
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_admin';
GO
EXEC sp_EstablecerContextoUsuario
    @nombre_usuario = 'admin',
    @contrasena = 'Admin#2026';
GO
EXEC sp_VerificarSesionActual;
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
REVERT;
GO

-- Estudiante: intentar matricular sin finalizar matricula activa anterior
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_estudiante';
GO
EXEC sp_EstablecerContextoUsuario
    @nombre_usuario = 'yeisson.villalobos',
    @contrasena = 'Estu#2026';
GO
EXEC sp_VerificarSesionActual;
GO
EXEC sp_ProcesoMatricula_EstudianteInscribir
    @id_estudiante = 5,
    @id_sede = 1,
    @fecha_matricula = '2026-02-01',
    @codigo_oficial = 'DEMO-401',
    @id_periodo = 7,
    @finalizar_anterior = 0;
GO
REVERT;
GO

-- Profesor: intentar aprobar con nota menor a 70
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_profesor';
GO
EXEC sp_EstablecerContextoUsuario
    @nombre_usuario = 'sofia.mora',
    @contrasena = 'Profe#2026';
GO
EXEC sp_VerificarSesionActual;
GO
EXEC sp_ProcesoMatricula_ProfesorEvaluarEstudiante
    @id_estudiante = 5,
    @codigo_oficial = 'DEMO-401',
    @id_periodo = 7,
    @promedio_final = 65.00,
    @estado_nota = 'Aprobado';
GO
REVERT;
GO
