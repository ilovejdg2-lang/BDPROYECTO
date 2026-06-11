/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 9/11
   PRUEBAS CRUD
   ============================================================================ */

--Sede

--Crear una sede
USE InstitutoTECNIC;
GO
EXEC sp_Sede_Insertar @nombre_sede = 'Sede CRUD Prueba', @direccion_sede = 'Liberia, Guanacaste';
GO
--Obtener una sede
USE InstitutoTECNIC;
GO
DECLARE @id_sede INT;
SELECT @id_sede = id_sede FROM Sede WHERE nombre_sede = 'Sede CRUD Prueba';
EXEC sp_Sede_Obtener @id_sede = @id_sede;
GO
--Actualizar una sede
USE InstitutoTECNIC;
GO
DECLARE @id_sede INT;
SELECT @id_sede = id_sede FROM Sede WHERE nombre_sede = 'Sede CRUD Prueba';
EXEC sp_Sede_Actualizar
    @id_sede = @id_sede,
    @nombre_sede = 'Sede CRUD Actualizada',
    @direccion_sede = 'Nicoya, Guanacaste';
GO
--Obtener una sede
USE InstitutoTECNIC;
GO
DECLARE @id_sede INT;
SELECT @id_sede = id_sede FROM Sede WHERE nombre_sede = 'Sede CRUD Actualizada';
EXEC sp_Sede_Obtener @id_sede = @id_sede;
GO
--Eliminar una sede
USE InstitutoTECNIC;
GO
DECLARE @id_sede INT;
SELECT @id_sede = id_sede FROM Sede WHERE nombre_sede = 'Sede CRUD Actualizada';
EXEC sp_Sede_Eliminar @id_sede = @id_sede;
GO
--Aula

--Crear una aula
USE InstitutoTECNIC;
GO
EXEC sp_Aula_Insertar
    @numero_aula = 888, @nombre_aula = 'Aula CRUD Prueba', @capacidad = 24,
    @metros_cuadrados = 35.50, @tiene_proyector = 1, @id_sede = 1;
GO
--Obtener un aula
USE InstitutoTECNIC;
GO
DECLARE @id_aula INT;
SELECT @id_aula = id_aula FROM Aula WHERE numero_aula = 888 AND id_sede = 1;
EXEC sp_Aula_Obtener @id_aula = @id_aula;
GO
--Actualizar un aula
USE InstitutoTECNIC;
GO
DECLARE @id_aula INT;
SELECT @id_aula = id_aula FROM Aula WHERE numero_aula = 888 AND id_sede = 1;
EXEC sp_Aula_Actualizar
    @id_aula = @id_aula,
    @numero_aula = 887, @nombre_aula = 'Aula CRUD Actualizada', @capacidad = 26,
    @metros_cuadrados = 36.00, @tiene_proyector = 0, @id_sede = 1;
GO
--Obtener un aula
USE InstitutoTECNIC;
GO
DECLARE @id_aula INT;
SELECT @id_aula = id_aula FROM Aula WHERE numero_aula = 887 AND id_sede = 1;
EXEC sp_Aula_Obtener @id_aula = @id_aula;
GO
--Eliminar un aula
USE InstitutoTECNIC;
GO
DECLARE @id_aula INT;
SELECT @id_aula = id_aula FROM Aula WHERE numero_aula = 887 AND id_sede = 1;
EXEC sp_Aula_Eliminar @id_aula = @id_aula;
GO

