/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 8/9
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
--Ciclo

--Crear un ciclo
USE InstitutoTECNIC;
GO
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Ciclo CRUD Prueba', @categoria = 'Grado Medio';
GO
--Obtener un ciclo
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_ciclo INT;
SELECT @codigo_interno_ciclo = codigo_interno_ciclo FROM Ciclo WHERE nombre_ciclo = 'Ciclo CRUD Prueba';
EXEC sp_Ciclo_Obtener @codigo_interno_ciclo = @codigo_interno_ciclo;
GO
--Actualizar un ciclo
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_ciclo INT;
SELECT @codigo_interno_ciclo = codigo_interno_ciclo FROM Ciclo WHERE nombre_ciclo = 'Ciclo CRUD Prueba';
EXEC sp_Ciclo_Actualizar
    @codigo_interno_ciclo = @codigo_interno_ciclo,
    @nombre_ciclo = 'Ciclo CRUD Actualizado', @categoria = 'Grado Superior';
GO
--Obtener un ciclo
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_ciclo INT;
SELECT @codigo_interno_ciclo = codigo_interno_ciclo FROM Ciclo WHERE nombre_ciclo = 'Ciclo CRUD Actualizado';
EXEC sp_Ciclo_Obtener @codigo_interno_ciclo = @codigo_interno_ciclo;
GO
--Eliminar un ciclo
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_ciclo INT;
SELECT @codigo_interno_ciclo = codigo_interno_ciclo FROM Ciclo WHERE nombre_ciclo = 'Ciclo CRUD Actualizado';
EXEC sp_Ciclo_Eliminar @codigo_interno_ciclo = @codigo_interno_ciclo;
GO
--Curso

--Crear un curso
USE InstitutoTECNIC;
GO
EXEC sp_Curso_Insertar @nivel_curso = 'Tercer Año', @codigo_interno_ciclo = 1;
GO
--Obtener un curso
USE InstitutoTECNIC;
GO
DECLARE @id_curso INT;
SELECT @id_curso = id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 1;
EXEC sp_Curso_Obtener @id_curso = @id_curso;
GO
--Actualizar un curso
USE InstitutoTECNIC;
GO
DECLARE @id_curso INT;
SELECT @id_curso = id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 1;
EXEC sp_Curso_Actualizar
    @id_curso = @id_curso,
    @nivel_curso = 'Tercer Año', @codigo_interno_ciclo = 2;
GO
--Obtener un curso
USE InstitutoTECNIC;
GO
DECLARE @id_curso INT;
SELECT @id_curso = id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 2;
EXEC sp_Curso_Obtener @id_curso = @id_curso;
GO
--Eliminar un curso
USE InstitutoTECNIC;
GO
DECLARE @id_curso INT;
SELECT @id_curso = id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 2;
EXEC sp_Curso_Eliminar @id_curso = @id_curso;
GO
--Usuario

--Crear un usuario
USE InstitutoTECNIC;
GO
EXEC sp_Usuario_Insertar
    @nombre_usuario = 'crud.prueba', @correo_usuario = 'crud.prueba@tecnic.cr',
    @contrasena_plana = 'Demo#2026', @rol = 'Usuario';
GO
--Obtener un usuario
USE InstitutoTECNIC;
GO
DECLARE @id_usuario INT;
SELECT @id_usuario = id_usuario FROM Usuario WHERE nombre_usuario = 'crud.prueba';
EXEC sp_Usuario_Obtener @id_usuario = @id_usuario;
GO
--Actualizar un usuario
USE InstitutoTECNIC;
GO
DECLARE @id_usuario INT;
SELECT @id_usuario = id_usuario FROM Usuario WHERE nombre_usuario = 'crud.prueba';
EXEC sp_Usuario_Actualizar
    @id_usuario = @id_usuario,
    @correo_usuario = 'crud.actualizado@tecnic.cr', @rol = 'Usuario';
GO
--Obtener un usuario
USE InstitutoTECNIC;
GO
DECLARE @id_usuario INT;
SELECT @id_usuario = id_usuario FROM Usuario WHERE nombre_usuario = 'crud.prueba';
EXEC sp_Usuario_Obtener @id_usuario = @id_usuario;
GO
--Eliminar un usuario
USE InstitutoTECNIC;
GO
DECLARE @id_usuario INT;
SELECT @id_usuario = id_usuario FROM Usuario WHERE nombre_usuario = 'crud.prueba';
EXEC sp_Usuario_Eliminar @id_usuario = @id_usuario;
GO
--Bitacora
--Solo lectura: la bitacora se inserta por triggers

--Obtener un registro de bitacora
USE InstitutoTECNIC;
GO
DECLARE @id_bitacora INT;
SELECT @id_bitacora = MAX(id_bitacora) FROM Bitacora;
EXEC sp_Bitacora_Obtener @id_bitacora = @id_bitacora;
GO
--Profesor

--Crear un profesor
USE InstitutoTECNIC;
GO
EXEC sp_Profesor_Insertar
    @cedula_profesor = '1-8888-0001', @nombre_profesor = 'Mariana', @apellido1_profesor = 'CRUD',
    @telefono_profesor = '+506 8888-1111', @direccion_profesor = 'Liberia';
GO
--Obtener un profesor
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_profesor INT;
SELECT @codigo_interno_profesor = codigo_interno_profesor FROM Profesor WHERE cedula_profesor = '1-8888-0001';
EXEC sp_Profesor_Obtener @codigo_interno_profesor = @codigo_interno_profesor;
GO
--Actualizar un profesor
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_profesor INT;
SELECT @codigo_interno_profesor = codigo_interno_profesor FROM Profesor WHERE cedula_profesor = '1-8888-0001';
EXEC sp_Profesor_Actualizar
    @codigo_interno_profesor = @codigo_interno_profesor,
    @nombre_profesor = 'Mariana Act', @apellido1_profesor = 'CRUD', @telefono_profesor = '+506 8888-2222';
GO
--Obtener un profesor
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_profesor INT;
SELECT @codigo_interno_profesor = codigo_interno_profesor FROM Profesor WHERE cedula_profesor = '1-8888-0001';
EXEC sp_Profesor_Obtener @codigo_interno_profesor = @codigo_interno_profesor;
GO
--Eliminar un profesor
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_profesor INT;
SELECT @codigo_interno_profesor = codigo_interno_profesor FROM Profesor WHERE cedula_profesor = '1-8888-0001';
EXEC sp_Profesor_Eliminar @codigo_interno_profesor = @codigo_interno_profesor;
GO
--Periodo

--Crear un periodo
USE InstitutoTECNIC;
GO
EXEC sp_Periodo_Insertar @nombre_periodo = 'I-Semestre', @annio = 2099;
GO
--Obtener un periodo
USE InstitutoTECNIC;
GO
DECLARE @id_periodo INT;
SELECT @id_periodo = id_periodo FROM Periodo WHERE nombre_periodo = 'I-Semestre' AND annio = 2099;
EXEC sp_Periodo_Obtener @id_periodo = @id_periodo;
GO
--Actualizar un periodo
USE InstitutoTECNIC;
GO
DECLARE @id_periodo INT;
SELECT @id_periodo = id_periodo FROM Periodo WHERE nombre_periodo = 'I-Semestre' AND annio = 2099;
EXEC sp_Periodo_Actualizar
    @id_periodo = @id_periodo,
    @nombre_periodo = 'II-Semestre', @annio = 2099;
GO
--Obtener un periodo
USE InstitutoTECNIC;
GO
DECLARE @id_periodo INT;
SELECT @id_periodo = id_periodo FROM Periodo WHERE nombre_periodo = 'II-Semestre' AND annio = 2099;
EXEC sp_Periodo_Obtener @id_periodo = @id_periodo;
GO
--Eliminar un periodo
USE InstitutoTECNIC;
GO
DECLARE @id_periodo INT;
SELECT @id_periodo = id_periodo FROM Periodo WHERE nombre_periodo = 'II-Semestre' AND annio = 2099;
EXEC sp_Periodo_Eliminar @id_periodo = @id_periodo;
GO
--Asignatura

--Crear una asignatura
USE InstitutoTECNIC;
GO
EXEC sp_Asignatura_Insertar
    @codigo_oficial = 'CRUD-901', @nombre_asignatura = 'Asignatura CRUD Prueba',
    @duracion_horas_asignatura = 60, @id_aula = 3, @id_periodo = 7,
    @codigo_interno_profesor = 1, @fecha_inicio_imparticion_profe = '2026-03-01';
GO
--Obtener una asignatura
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-901' AND id_periodo = 7;
EXEC sp_Asignatura_Obtener @codigo_interno_asignatura = @codigo_interno_asignatura;
GO
--Actualizar una asignatura
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-901' AND id_periodo = 7;
EXEC sp_Asignatura_Actualizar
    @codigo_interno_asignatura = @codigo_interno_asignatura,
    @nombre_asignatura = 'Asignatura CRUD Actualizada', @duracion_horas_asignatura = 70, @id_aula = 3;
GO
--Obtener una asignatura
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-901' AND id_periodo = 7;
EXEC sp_Asignatura_Obtener @codigo_interno_asignatura = @codigo_interno_asignatura;
GO
--Eliminar una asignatura
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-901' AND id_periodo = 7;
DELETE FROM AsignaturaProfesor WHERE codigo_interno_asignatura = (SELECT codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-901' AND id_periodo = 7);
EXEC sp_Asignatura_Eliminar @codigo_interno_asignatura = @codigo_interno_asignatura;
GO
--AsignaturaProfesor

--Asignar profesor a asignatura
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01';
EXEC sp_AsignaturaProfesor_Asignar
    @codigo_interno_profesor = 2,
    @codigo_interno_asignatura = @codigo_interno_asignatura,
    @fecha_inicio_imparticion = '2026-03-01';
GO
--Obtener asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_profesor INT;
SELECT @id_asignatura_profesor = (SELECT id_asignatura_profesor FROM AsignaturaProfesor
    WHERE codigo_interno_asignatura = (SELECT codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01'));
EXEC sp_AsignaturaProfesor_Obtener @id_asignatura_profesor = @id_asignatura_profesor;
GO
--Actualizar asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_profesor INT;
SELECT @id_asignatura_profesor = (SELECT id_asignatura_profesor FROM AsignaturaProfesor
        WHERE codigo_interno_asignatura = (SELECT codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01'));
EXEC sp_AsignaturaProfesor_Actualizar
    @id_asignatura_profesor = @id_asignatura_profesor,
    @fecha_inicio_imparticion = '2026-04-01', @fecha_fin_imparticion = '2026-08-30';
GO
--Obtener asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_profesor INT;
SELECT @id_asignatura_profesor = (SELECT id_asignatura_profesor FROM AsignaturaProfesor
    WHERE codigo_interno_asignatura = (SELECT codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01'));
EXEC sp_AsignaturaProfesor_Obtener @id_asignatura_profesor = @id_asignatura_profesor;
GO
--Eliminar asignacion profesor-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_profesor INT;
SELECT @id_asignatura_profesor = (SELECT id_asignatura_profesor FROM AsignaturaProfesor
    WHERE codigo_interno_asignatura = (SELECT codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01'));
EXEC sp_AsignaturaProfesor_Eliminar @id_asignatura_profesor = @id_asignatura_profesor;
DELETE FROM Asignatura WHERE codigo_oficial = 'CRUD-AP01';
GO
--BloqueHorario

--Obtener un bloque horario (bloque 6 ya cargado en script 6)
USE InstitutoTECNIC;
GO
EXEC sp_BloqueHorario_Obtener @num_bloque = 6;
GO
--Actualizar un bloque horario
USE InstitutoTECNIC;
GO
EXEC sp_BloqueHorario_Actualizar @num_bloque = 6, @hora_inicio_bloque = '18:30', @hora_fin_bloque = '20:00';
GO
--Obtener un bloque horario
USE InstitutoTECNIC;
GO
EXEC sp_BloqueHorario_Obtener @num_bloque = 6;
GO
--Horario

--Crear un horario
USE InstitutoTECNIC;
GO
EXEC sp_HorarioBloque_Insertar @dia_semana = 'Viernes', @num_bloque = 5;
GO
--Obtener un horario
USE InstitutoTECNIC;
GO
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Viernes' AND num_bloque = 5;
EXEC sp_Horario_Obtener @id_horario = @id_horario;
GO
--Actualizar un horario
USE InstitutoTECNIC;
GO
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Viernes' AND num_bloque = 5;
EXEC sp_Horario_Actualizar
    @id_horario = @id_horario,
    @dia_semana = 'Viernes', @num_bloque = 6;
GO
--Obtener un horario
USE InstitutoTECNIC;
GO
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Viernes' AND num_bloque = 6;
EXEC sp_Horario_Obtener @id_horario = @id_horario;
GO
--Eliminar un horario
USE InstitutoTECNIC;
GO
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Viernes' AND num_bloque = 6;
EXEC sp_Horario_Eliminar @id_horario = @id_horario;
GO
--HorarioAsignatura

--Crear un horario
USE InstitutoTECNIC;
GO
EXEC sp_HorarioBloque_Insertar @dia_semana = 'Sábado', @num_bloque = 6;
GO
--Asignar asignatura a horario
USE InstitutoTECNIC;
GO
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Sábado' AND num_bloque = 6;
EXEC sp_HorarioAsignatura_Asignar
    @id_horario = @id_horario,
    @codigo_interno_asignatura = 10;
GO
--Obtener asignacion horario-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_horario_asignatura INT;
SELECT @id_horario_asignatura = ha.id_horario_asignatura FROM HorarioAsignatura ha
    INNER JOIN Horario h ON h.id_horario = ha.id_horario
    WHERE h.dia_semana = 'Sábado' AND h.num_bloque = 6 AND ha.codigo_interno_asignatura = 10;
EXEC sp_HorarioAsignatura_Obtener @id_horario_asignatura = @id_horario_asignatura;
GO
--Eliminar asignacion horario-asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_horario_asignatura INT;
SELECT @id_horario_asignatura = ha.id_horario_asignatura FROM HorarioAsignatura ha
    INNER JOIN Horario h ON h.id_horario = ha.id_horario
    WHERE h.dia_semana = 'Sábado' AND h.num_bloque = 6 AND ha.codigo_interno_asignatura = 10;
DECLARE @id_horario INT;
SELECT @id_horario = id_horario FROM Horario WHERE dia_semana = 'Sábado' AND num_bloque = 6;
EXEC sp_HorarioAsignatura_Eliminar @id_horario_asignatura = @id_horario_asignatura;
EXEC sp_Horario_Eliminar @id_horario = @id_horario;
GO
--AsignaturaCiclo

--Crear enlace asignatura-ciclo
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-AC01';
EXEC sp_AsignaturaCiclo_Insertar
    @codigo_interno_asignatura = @codigo_interno_asignatura,
    @codigo_interno_ciclo = 1;
GO
--Obtener enlace asignatura-ciclo
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_ciclo INT;
SELECT @id_asignatura_ciclo = ac.id_asignatura_ciclo FROM AsignaturaCiclo ac
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ac.codigo_interno_asignatura
    WHERE a.codigo_oficial = 'CRUD-AC01' AND ac.codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Obtener @id_asignatura_ciclo = @id_asignatura_ciclo;
GO
--Eliminar enlace asignatura-ciclo
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_ciclo INT;
SELECT @id_asignatura_ciclo = ac.id_asignatura_ciclo FROM AsignaturaCiclo ac
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = ac.codigo_interno_asignatura
    WHERE a.codigo_oficial = 'CRUD-AC01' AND ac.codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Eliminar @id_asignatura_ciclo = @id_asignatura_ciclo;
DELETE FROM Asignatura WHERE codigo_oficial = 'CRUD-AC01';
GO
--AsignaturaCurso

--Crear enlace asignatura-curso
USE InstitutoTECNIC;
GO
DECLARE @codigo_interno_asignatura INT;
SELECT @codigo_interno_asignatura = codigo_interno_asignatura FROM Asignatura WHERE codigo_oficial = 'CRUD-ACU01';
EXEC sp_AsignaturaCurso_Insertar
    @codigo_interno_asignatura = @codigo_interno_asignatura,
    @id_curso = 2;
GO
--Obtener enlace asignatura-curso
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_curso INT;
SELECT @id_asignatura_curso = acu.id_asignatura_curso FROM AsignaturaCurso acu
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = acu.codigo_interno_asignatura
    WHERE a.codigo_oficial = 'CRUD-ACU01' AND acu.id_curso = 2;
EXEC sp_AsignaturaCurso_Obtener @id_asignatura_curso = @id_asignatura_curso;
GO
--Eliminar enlace asignatura-curso
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_curso INT;
SELECT @id_asignatura_curso = acu.id_asignatura_curso FROM AsignaturaCurso acu
    INNER JOIN Asignatura a ON a.codigo_interno_asignatura = acu.codigo_interno_asignatura
    WHERE a.codigo_oficial = 'CRUD-ACU01' AND acu.id_curso = 2;
EXEC sp_AsignaturaCurso_Eliminar @id_asignatura_curso = @id_asignatura_curso;
DELETE FROM Asignatura WHERE codigo_oficial = 'CRUD-ACU01';
GO
--Prerrequisito

--Crear un prerrequisito
USE InstitutoTECNIC;
GO
EXEC sp_Prerrequisito_Insertar
    @codigo_oficial_asignatura_prerequerida = 'PRO-101',
    @nombre_asignatura_prerequisito = 'Prerrequisito CRUD Prueba';
GO
--Obtener un prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito CRUD Prueba';
EXEC sp_Prerrequisito_Obtener @id_prerrequisito = @id_prerrequisito;
GO
--Actualizar un prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito CRUD Prueba';
EXEC sp_Prerrequisito_Actualizar
    @id_prerrequisito = @id_prerrequisito,
    @estado_prerrequisito = 'Activo', @nombre_asignatura_prerequisito = 'Prerrequisito CRUD Actualizado';
GO
--Obtener un prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito CRUD Actualizado';
EXEC sp_Prerrequisito_Obtener @id_prerrequisito = @id_prerrequisito;
GO
--Eliminar un prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito CRUD Actualizado';
EXEC sp_Prerrequisito_Eliminar @id_prerrequisito = @id_prerrequisito;
GO
--Eliminar un prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_prerrequisito INT;
SELECT @id_asignatura_prerrequisito = ap.id_asignatura_prerrequisito FROM AsignaturaPrerrequisito ap
    INNER JOIN Prerrequisito p ON p.id_prerrequisito = ap.id_prerrequisito
    WHERE ap.codigo_interno_asignatura = 12 AND p.nombre_asignatura_prerequisito = 'Prerrequisito Enlace CRUD';
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito Enlace CRUD';
EXEC sp_AsignaturaPrerrequisito_Eliminar @id_asignatura_prerrequisito = @id_asignatura_prerrequisito;
EXEC sp_Prerrequisito_Eliminar @id_prerrequisito = @id_prerrequisito;
GO
--AsignaturaPrerrequisito

--Asignar prerrequisito a asignatura
USE InstitutoTECNIC;
GO
DECLARE @id_prerrequisito INT;
SELECT @id_prerrequisito = id_prerrequisito FROM Prerrequisito WHERE nombre_asignatura_prerequisito = 'Prerrequisito Enlace CRUD';
EXEC sp_AsignaturaPrerrequisito_Asignar
    @codigo_interno_asignatura = 12,
    @id_prerrequisito = @id_prerrequisito;
GO
--Obtener enlace asignatura-prerrequisito
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_prerrequisito INT;
SELECT @id_asignatura_prerrequisito = ap.id_asignatura_prerrequisito FROM AsignaturaPrerrequisito ap
    INNER JOIN Prerrequisito p ON p.id_prerrequisito = ap.id_prerrequisito
    WHERE ap.codigo_interno_asignatura = 12 AND p.nombre_asignatura_prerequisito = 'Prerrequisito Enlace CRUD';
EXEC sp_AsignaturaPrerrequisito_Obtener @id_asignatura_prerrequisito = @id_asignatura_prerrequisito;
GO
--Estudiante

--Crear un estudiante
USE InstitutoTECNIC;
GO
EXEC sp_Estudiante_Insertar
    @cedula_estudiante = '1-7777-0001', @seguro_social_estudiante = 77770001, @nombre_estudiante = 'Laura', @apellido1_estudiante = 'CRUD',
    @fecha_nacimiento = '2005-06-15', @telefono_estudiante = '+506 7000-1111';
GO
--Obtener un estudiante
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0001';
EXEC sp_Estudiante_Obtener @id_estudiante = @id_estudiante;
GO
--Actualizar un estudiante
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0001';
EXEC sp_Estudiante_Actualizar
    @id_estudiante = @id_estudiante,
    @telefono_estudiante = '+506 7000-2222';
GO
--Obtener un estudiante
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0001';
EXEC sp_Estudiante_Obtener @id_estudiante = @id_estudiante;
GO
--Eliminar un estudiante
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0001';
EXEC sp_Estudiante_Eliminar @id_estudiante = @id_estudiante;
GO
--Matricula

--Crear una matricula
USE InstitutoTECNIC;
GO
EXEC sp_Estudiante_Insertar
    @cedula_estudiante = '1-7777-0002', @seguro_social_estudiante = 77770002, @nombre_estudiante = 'Pedro', @apellido1_estudiante = 'Matricula';
GO
--Crear una matricula
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0002';
EXEC sp_Matricula_Insertar
    @id_estudiante = @id_estudiante,
    @id_sede = 1;
GO
--Obtener una matricula
USE InstitutoTECNIC;
GO
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m
    INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0002';
EXEC sp_Matricula_Obtener @id_matricula = @id_matricula;
GO
--Actualizar una matricula
USE InstitutoTECNIC;
GO
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m
        INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
        WHERE e.cedula_estudiante = '1-7777-0002';
EXEC sp_Matricula_Actualizar
    @id_matricula = @id_matricula,
    @estado_matricula = 'Anulada';
GO
--Obtener una matricula
USE InstitutoTECNIC;
GO
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m
    INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0002';
EXEC sp_Matricula_Obtener @id_matricula = @id_matricula;
GO
--Eliminar una matricula
USE InstitutoTECNIC;
GO
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m
    INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0002';
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0002';
EXEC sp_Matricula_Eliminar @id_matricula = @id_matricula;
EXEC sp_Estudiante_Eliminar @id_estudiante = @id_estudiante;
GO
--AsignaturaMatricula

--Crear inscripcion de asignatura en matricula
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0003';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '1-7777-0003', @seguro_social_estudiante = 77770003, @nombre_estudiante = 'Ana', @apellido1_estudiante = 'AsigMat';
EXEC sp_Matricula_Insertar
    @id_estudiante = @id_estudiante,
    @id_sede = 1;
GO
--Crear inscripcion de asignatura en matricula
USE InstitutoTECNIC;
GO
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m
        INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
        WHERE e.cedula_estudiante = '1-7777-0003';
EXEC sp_AsignaturaMatricula_Insertar
    @codigo_interno_asignatura = 10,
    @id_matricula = @id_matricula;
GO
--Obtener inscripcion de asignatura en matricula
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_matricula INT;
SELECT @id_asignatura_matricula = am.id_asignatura_matricula FROM AsignaturaMatricula am
    INNER JOIN Matricula m ON m.id_matricula = am.id_matricula
    INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0003' AND am.codigo_interno_asignatura = 10;
EXEC sp_AsignaturaMatricula_Obtener @id_asignatura_matricula = @id_asignatura_matricula;
GO
--Eliminar inscripcion de asignatura en matricula
USE InstitutoTECNIC;
GO
DECLARE @id_asignatura_matricula INT;
SELECT @id_asignatura_matricula = am.id_asignatura_matricula FROM AsignaturaMatricula am
    INNER JOIN Matricula m ON m.id_matricula = am.id_matricula
    INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0003' AND am.codigo_interno_asignatura = 10;
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante WHERE e.cedula_estudiante = '1-7777-0003';
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0003';
EXEC sp_AsignaturaMatricula_Eliminar @id_asignatura_matricula = @id_asignatura_matricula;
EXEC sp_Matricula_Eliminar @id_matricula = @id_matricula;
EXEC sp_Estudiante_Eliminar @id_estudiante = @id_estudiante;
GO
--NotaFinal

--Crear una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0004';
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
        WHERE e.cedula_estudiante = '1-7777-0004';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '1-7777-0004', @seguro_social_estudiante = 77770004, @nombre_estudiante = 'Luis', @apellido1_estudiante = 'Nota';
EXEC sp_Matricula_Insertar
    @id_estudiante = @id_estudiante, @id_sede = 1;
EXEC sp_AsignaturaMatricula_Insertar
    @codigo_interno_asignatura = 10,
    @id_matricula = @id_matricula;
GO
--Crear una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0004';
EXEC sp_NotaFinal_Insertar
    @estado_nota = 'En curso',
    @id_estudiante = @id_estudiante,
    @codigo_interno_asignatura = 10;
GO
--Obtener una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_nota_final INT;
SELECT @id_nota_final = nf.id_nota_final FROM NotaFinal nf
    INNER JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0004' AND nf.codigo_interno_asignatura = 10;
EXEC sp_NotaFinal_Obtener @id_nota_final = @id_nota_final;
GO
--Actualizar una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0004';
EXEC sp_NotaFinal_Actualizar
    @id_estudiante = @id_estudiante,
    @codigo_interno_asignatura = 10, @promedio_final = 88, @estado_nota = 'Aprobado';
GO
--Obtener una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_nota_final INT;
SELECT @id_nota_final = nf.id_nota_final FROM NotaFinal nf
    INNER JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0004' AND nf.codigo_interno_asignatura = 10;
EXEC sp_NotaFinal_Obtener @id_nota_final = @id_nota_final;
GO
--Eliminar una nota final
USE InstitutoTECNIC;
GO
DECLARE @id_nota_final INT;
SELECT @id_nota_final = nf.id_nota_final FROM NotaFinal nf INNER JOIN Estudiante e ON e.id_estudiante = nf.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0004' AND nf.codigo_interno_asignatura = 10;
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante WHERE e.cedula_estudiante = '1-7777-0004';
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0004';
EXEC sp_NotaFinal_Eliminar @id_nota_final = @id_nota_final;
DELETE FROM AsignaturaMatricula WHERE id_matricula = (
    SELECT m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante WHERE e.cedula_estudiante = '1-7777-0004');
EXEC sp_Matricula_Eliminar @id_matricula = @id_matricula;
EXEC sp_Estudiante_Eliminar @id_estudiante = @id_estudiante;
GO
--Asistencia

--Crear una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0005';
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante
        WHERE e.cedula_estudiante = '1-7777-0005';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '1-7777-0005', @seguro_social_estudiante = 77770005, @nombre_estudiante = 'Sofia', @apellido1_estudiante = 'Asist';
EXEC sp_Matricula_Insertar
    @id_estudiante = @id_estudiante, @id_sede = 1;
EXEC sp_AsignaturaMatricula_Insertar
    @codigo_interno_asignatura = 10,
    @id_matricula = @id_matricula;
GO
--Crear una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0005';
EXEC sp_Asistencia_Insertar
    @id_estudiante = @id_estudiante,
    @codigo_interno_asignatura = 10, @estado_asistencia = 'Presente', @fecha_asistencia = '2026-03-10';
GO
--Obtener una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_asistencia INT;
SELECT @id_asistencia = a.id_asistencia FROM Asistencia a
    INNER JOIN Estudiante e ON e.id_estudiante = a.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0005' AND a.codigo_interno_asignatura = 10 AND CAST(a.fecha_asistencia AS DATE) = '2026-03-10';
EXEC sp_Asistencia_Obtener @id_asistencia = @id_asistencia;
GO
--Actualizar una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_asistencia INT;
SELECT @id_asistencia = a.id_asistencia FROM Asistencia a INNER JOIN Estudiante e ON e.id_estudiante = a.id_estudiante
        WHERE e.cedula_estudiante = '1-7777-0005' AND a.codigo_interno_asignatura = 10 AND CAST(a.fecha_asistencia AS DATE) = '2026-03-10';
EXEC sp_Asistencia_Actualizar
    @id_asistencia = @id_asistencia,
    @estado_asistencia = 'Tardía', @justificacion = NULL;
GO
--Obtener una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_asistencia INT;
SELECT @id_asistencia = a.id_asistencia FROM Asistencia a INNER JOIN Estudiante e ON e.id_estudiante = a.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0005' AND a.codigo_interno_asignatura = 10 AND CAST(a.fecha_asistencia AS DATE) = '2026-03-10';
EXEC sp_Asistencia_Obtener @id_asistencia = @id_asistencia;
GO
--Eliminar una asistencia
USE InstitutoTECNIC;
GO
DECLARE @id_asistencia INT;
SELECT @id_asistencia = a.id_asistencia FROM Asistencia a INNER JOIN Estudiante e ON e.id_estudiante = a.id_estudiante
    WHERE e.cedula_estudiante = '1-7777-0005' AND a.codigo_interno_asignatura = 10 AND CAST(a.fecha_asistencia AS DATE) = '2026-03-10';
DECLARE @id_matricula INT;
SELECT @id_matricula = m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante WHERE e.cedula_estudiante = '1-7777-0005';
DECLARE @id_estudiante INT;
SELECT @id_estudiante = id_estudiante FROM Estudiante WHERE cedula_estudiante = '1-7777-0005';
EXEC sp_Asistencia_Eliminar @id_asistencia = @id_asistencia;
DELETE FROM AsignaturaMatricula WHERE id_matricula = (
    SELECT m.id_matricula FROM Matricula m INNER JOIN Estudiante e ON e.id_estudiante = m.id_estudiante WHERE e.cedula_estudiante = '1-7777-0005');
EXEC sp_Matricula_Eliminar @id_matricula = @id_matricula;
EXEC sp_Estudiante_Eliminar @id_estudiante = @id_estudiante;
GO
--Tutoria

--Crear un curso
USE InstitutoTECNIC;
GO
EXEC sp_Curso_Insertar @nivel_curso = 'Tercer Año', @codigo_interno_ciclo = 2;
GO
--Crear una tutoria
USE InstitutoTECNIC;
GO
DECLARE @id_curso INT;
SELECT @id_curso = (SELECT TOP 1 id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 2 ORDER BY id_curso DESC);
EXEC sp_Tutoria_Insertar
    @codigo_interno_profesor = 3,
    @id_curso = @id_curso,
    @fecha_inicio_tutoria = '2026-03-01';
GO
--Obtener una tutoria
USE InstitutoTECNIC;
GO
DECLARE @id_tutoria INT;
SELECT @id_tutoria = (SELECT TOP 1 t.id_tutoria FROM Tutoria t
    INNER JOIN Curso c ON c.id_curso = t.id_curso
    WHERE c.nivel_curso = 'Tercer Año' AND c.codigo_interno_ciclo = 2 AND t.codigo_interno_profesor = 3
    ORDER BY t.id_tutoria DESC);
EXEC sp_Tutoria_Obtener @id_tutoria = @id_tutoria;
GO
--Actualizar una tutoria
USE InstitutoTECNIC;
GO
DECLARE @id_tutoria INT;
SELECT @id_tutoria = (SELECT TOP 1 t.id_tutoria FROM Tutoria t INNER JOIN Curso c ON c.id_curso = t.id_curso
        WHERE c.nivel_curso = 'Tercer Año' AND c.codigo_interno_ciclo = 2 AND t.codigo_interno_profesor = 3 ORDER BY t.id_tutoria DESC);
EXEC sp_Tutoria_Actualizar
    @id_tutoria = @id_tutoria,
    @fecha_inicio_tutoria = '2026-03-15', @fecha_fin_tutoria = '2026-12-15';
GO
--Obtener una tutoria
USE InstitutoTECNIC;
GO
DECLARE @id_tutoria INT;
SELECT @id_tutoria = (SELECT TOP 1 t.id_tutoria FROM Tutoria t INNER JOIN Curso c ON c.id_curso = t.id_curso
    WHERE c.nivel_curso = 'Tercer Año' AND c.codigo_interno_ciclo = 2 AND t.codigo_interno_profesor = 3 ORDER BY t.id_tutoria DESC);
EXEC sp_Tutoria_Obtener @id_tutoria = @id_tutoria;
GO
--Eliminar una tutoria
USE InstitutoTECNIC;
GO
DECLARE @id_tutoria INT;
SELECT @id_tutoria = (SELECT TOP 1 t.id_tutoria FROM Tutoria t INNER JOIN Curso c ON c.id_curso = t.id_curso
    WHERE c.nivel_curso = 'Tercer Año' AND c.codigo_interno_ciclo = 2 AND t.codigo_interno_profesor = 3 ORDER BY t.id_tutoria DESC);
DECLARE @id_curso INT;
SELECT @id_curso = (SELECT TOP 1 id_curso FROM Curso WHERE nivel_curso = 'Tercer Año' AND codigo_interno_ciclo = 2 ORDER BY id_curso DESC);
EXEC sp_Tutoria_Eliminar @id_tutoria = @id_tutoria;
EXEC sp_Curso_Eliminar @id_curso = @id_curso;
GO
