/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 9/10
   PRUEBAS DE SEGURIDAD (USUARIOS, ROLES, LOGIN Y BITACORA)
   Requiere ejecutar antes: 1, 2, 3, 4, 5 y 6
   ============================================================================ */

--Validar login de administrador
USE InstitutoTECNIC;
GO
EXEC sp_ValidarLogin @nombre_usuario = 'admin', @contrasena = 'Admin#2026';
GO

--Validar login de profesor
USE InstitutoTECNIC;
GO
EXEC sp_ValidarLogin @nombre_usuario = 'dinia.medina', @contrasena = 'Profe#2026';
GO

--Validar login de estudiante
USE InstitutoTECNIC;
GO
EXEC sp_ValidarLogin @nombre_usuario = 'yeisson.villalobos', @contrasena = 'Estu#2026';
GO

--Establecer contexto de sesion (administrador)
USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'admin', @contrasena = 'Admin#2026';
GO

--Obtener usuario administrador
USE InstitutoTECNIC;
GO
DECLARE @id_usuario INT;
SELECT @id_usuario = id_usuario FROM Usuario WHERE nombre_usuario = 'admin';
EXEC sp_Usuario_Obtener @id_usuario = @id_usuario;
GO

--Crear usuario de prueba para seguridad
USE InstitutoTECNIC;
GO
EXEC sp_Usuario_Insertar
    @nombre_usuario = 'prueba.seguridad',
    @correo_usuario = 'prueba.seguridad@tecnic.cr',
    @contrasena_plana = 'Prueba#2026',
    @rol = 'Usuario';
GO

--Obtener usuario de prueba
USE InstitutoTECNIC;
GO
DECLARE @id_usuario_prueba INT;
SELECT @id_usuario_prueba = id_usuario FROM Usuario WHERE nombre_usuario = 'prueba.seguridad';
EXEC sp_Usuario_Obtener @id_usuario = @id_usuario_prueba;
GO

--Actualizar usuario de prueba
USE InstitutoTECNIC;
GO
DECLARE @id_usuario_prueba INT;
SELECT @id_usuario_prueba = id_usuario FROM Usuario WHERE nombre_usuario = 'prueba.seguridad';
EXEC sp_Usuario_Actualizar
    @id_usuario = @id_usuario_prueba,
    @correo_usuario = 'prueba.actualizada@tecnic.cr',
    @rol = 'Estudiante';
GO

--Cambiar contrasena del usuario de prueba
USE InstitutoTECNIC;
GO
DECLARE @id_usuario_prueba INT;
SELECT @id_usuario_prueba = id_usuario FROM Usuario WHERE nombre_usuario = 'prueba.seguridad';
EXEC sp_CambiarContrasena
    @id_usuario = @id_usuario_prueba,
    @contrasena_actual = 'Prueba#2026',
    @contrasena_nueva = 'Nueva#2026';
GO

--Validar login con la nueva contrasena
USE InstitutoTECNIC;
GO
EXEC sp_ValidarLogin @nombre_usuario = 'prueba.seguridad', @contrasena = 'Nueva#2026';
GO

--Desactivar usuario de prueba (queda en bitacora; no se elimina para conservar auditoria)
USE InstitutoTECNIC;
GO
DECLARE @id_usuario_prueba INT;
SELECT @id_usuario_prueba = id_usuario FROM Usuario WHERE nombre_usuario = 'prueba.seguridad';
EXEC sp_DesactivarUsuario @id_usuario = @id_usuario_prueba;
GO

--Consultar bitacora general
USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_Listar @top = 10;
GO

--Consultar bitacora por rol administrador
USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Administrador', @top = 5;
GO

--Consultar bitacora por rol profesor
USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Profesor', @top = 5;
GO

--Consultar bitacora por rol estudiante
USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_ListarPorRol @rol = 'Estudiante', @top = 5;
GO

--Obtener un registro de bitacora
USE InstitutoTECNIC;
GO
DECLARE @id_bitacora INT;
SELECT @id_bitacora = MAX(id_bitacora) FROM Bitacora;
EXEC sp_Bitacora_Obtener @id_bitacora = @id_bitacora;
GO

--Permisos del rol profesor (lectura y notas/asistencias)
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_profesor';
SELECT TOP 3 codigo_interno_asignatura, codigo_oficial, nombre_asignatura FROM Asignatura;
SELECT TOP 3 id_nota_final, id_estudiante, codigo_interno_asignatura, promedio_final FROM NotaFinal;
REVERT;
GO

--Permisos del rol estudiante (solo lectura)
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_estudiante';
SELECT TOP 3 codigo_interno_asignatura, codigo_oficial, nombre_asignatura FROM Asignatura;
SELECT TOP 3 id_nota_final, id_estudiante, codigo_interno_asignatura, promedio_final FROM NotaFinal;
REVERT;
GO

--Permisos del rol administrador (acceso amplio)
USE InstitutoTECNIC;
GO
EXECUTE AS USER = 'tecnic_admin';
SELECT TOP 5 id_usuario, nombre_usuario, rol, activo FROM Usuario ORDER BY id_usuario;
EXEC sp_Bitacora_Listar @top = 5;
REVERT;
GO

--Contexto de profesor y consulta de bitacora filtrada
USE InstitutoTECNIC;
GO
EXEC sp_EstablecerContextoUsuario @nombre_usuario = 'jose.jimenez', @contrasena = 'Profe#2026';
GO
USE InstitutoTECNIC;
GO
EXEC sp_Bitacora_Listar
    @id_usuario = (SELECT id_usuario FROM Usuario WHERE nombre_usuario = 'jose.jimenez'),
    @top = 5;
GO
