/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 11/11
   PROCESO DE MATRICULA (FLUJO CORRECTO)
   ============================================================================ */

-- Administrador: ofertar asignatura
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
    @codigo_oficial = 'DEMO-401',
    @nombre_asignatura = 'Aplicaciones Moviles',
    @duracion_horas_asignatura = 90,
    @id_aula = 3,
    @id_periodo = 7,
    @codigo_interno_profesor = 6,
    @id_curso = 7,
    @codigo_interno_ciclo = 4,
    @fecha_inicio_imparticion_profe = '2026-02-01';
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Administrador', @top = 3;
GO
REVERT;
GO

-- Profesor: cerrar prerrequisito de Administracion General
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_profesor';
GO
EXEC sp_EstablecerContextoUsuario
    @nombre_usuario = 'dinia.medina',
    @contrasena = 'Profe#2026';
GO
EXEC sp_VerificarSesionActual;
GO
EXEC sp_NotaFinal_Actualizar
    @id_estudiante = 5,
    @codigo_interno_asignatura = 20,
    @promedio_final = 82.00,
    @estado_nota = 'Aprobado';
GO
REVERT;
GO

-- Profesor: cerrar prerrequisito de Ingles Tecnico
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_profesor';
GO
EXEC sp_EstablecerContextoUsuario
    @nombre_usuario = 'dinia.medina',
    @contrasena = 'Profe#2026';
GO
EXEC sp_VerificarSesionActual;
GO
EXEC sp_NotaFinal_Actualizar
    @id_estudiante = 5,
    @codigo_interno_asignatura = 24,
    @promedio_final = 76.00,
    @estado_nota = 'Aprobado';
GO
REVERT;
GO

-- Administrador: consultar bitacora de profesores
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
EXEC sp_Bitacora_ListarPorRol @rol = 'Profesor', @top = 4;
GO
REVERT;
GO

-- Estudiante: inscribir asignatura
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
    @finalizar_anterior = 1;
GO
REVERT;
GO

-- Administrador: consultar bitacora de estudiantes
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
EXEC sp_Bitacora_ListarPorRol @rol = 'Estudiante', @top = 5;
GO
REVERT;
GO

-- Profesor: registrar asistencia y nota final de la asignatura nueva
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
    @asistencias = '2026-03-10:Presente;2026-03-12:Presente;2026-03-14:Tardía',
    @promedio_final = 88.50,
    @estado_nota = 'Aprobado';
GO
REVERT;
GO

-- Administrador: consultar auditoria final
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
DECLARE @id_usuario_sofia INT;

SELECT @id_usuario_sofia = id_usuario
FROM Usuario
WHERE nombre_usuario = 'sofia.mora';

EXEC sp_Bitacora_Listar
    @id_usuario = @id_usuario_sofia,
    @top = 6;
GO

SELECT
    u.rol,
    u.nombre_usuario,
    b.fecha_bitacora,
    b.accion
FROM Bitacora b
INNER JOIN Usuario u ON u.id_usuario = b.id_usuario
WHERE u.nombre_usuario IN (
    'admin', 'dinia.medina', 'jose.jimenez', 'yeisson.villalobos', 'sofia.mora'
)
ORDER BY b.id_bitacora DESC;
GO
REVERT;
GO
