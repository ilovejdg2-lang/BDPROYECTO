/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 10/11
   PROCESO DE MATRICULA (FLUJO CORRECTO)
   ============================================================================ */

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'admin', @contrasena = 'Admin#2026';
GO

USE InstitutoTECNIC;
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

USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Administrador', @top = 3;
GO

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'dinia.medina', @contrasena = 'Profe#2026';
GO

USE InstitutoTECNIC;
GO
EXEC sp_NotaFinal_Actualizar
    @id_estudiante = 5,
    @codigo_interno_asignatura = 20,
    @promedio_final = 82.00,
    @estado_nota = 'Aprobado';
GO

USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'jose.jimenez', @contrasena = 'Profe#2026';
GO

USE InstitutoTECNIC;
GO
EXEC sp_NotaFinal_Actualizar
    @id_estudiante = 5,
    @codigo_interno_asignatura = 24,
    @promedio_final = 76.00,
    @estado_nota = 'Aprobado';
GO

USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Profesor', @top = 4;
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
    @finalizar_anterior = 1;
GO

USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Estudiante', @top = 5;
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
    @asistencias = '2026-03-10:Presente;2026-03-12:Presente;2026-03-14:Tardía',
    @promedio_final = 88.50,
    @estado_nota = 'Aprobado';
GO

USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_Listar
    @id_usuario = (SELECT id_usuario FROM Usuario WHERE nombre_usuario = 'sofia.mora'),
    @top = 6;
GO

USE InstitutoTECNIC;
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
