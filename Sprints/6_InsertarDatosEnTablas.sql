/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 6/7
   INSERCION DE DATOS (VIA PROCEDIMIENTOS ALMACENADOS)
   ============================================================================ */

-- SEDES
USE InstitutoTECNIC;
GO
EXEC sp_Sede_Insertar @nombre_sede = 'Sede Liberia', @direccion_sede = 'Liberia, Guanacaste';
EXEC sp_Sede_Insertar @nombre_sede = 'Sede Nicoya', @direccion_sede = 'Nicoya, Guanacaste';
EXEC sp_Sede_Insertar @nombre_sede = 'Sede Sarapiquí', @direccion_sede = 'Sarapiquí, Heredia';
EXEC sp_Sede_Insertar @nombre_sede = 'Sede Santa Cruz', @direccion_sede = 'Santa Cruz, Guanacaste';
EXEC sp_Sede_Insertar @nombre_sede = 'Sede Heredia', @direccion_sede = 'Heredia Centro';
GO

-- CICLOS
USE InstitutoTECNIC;
GO
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Redes y Telecomunicaciones', @categoria = 'Grado Superior';
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Contabilidad', @categoria = 'Grado Medio';
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Diseño Gráfico', @categoria = 'Bachillerato Técnico';
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Desarrollo de Software', @categoria = 'Grado Superior';
EXEC sp_Ciclo_Insertar @nombre_ciclo = 'Administración de Empresas', @categoria = 'Grado Medio';
GO

-- CURSOS
USE InstitutoTECNIC;
GO
EXEC sp_Curso_Insertar @nivel_curso = 'Primer Año', @codigo_interno_ciclo = 1;
EXEC sp_Curso_Insertar @nivel_curso = 'Segundo Año', @codigo_interno_ciclo = 1;
EXEC sp_Curso_Insertar @nivel_curso = 'Primer Año', @codigo_interno_ciclo = 2;
EXEC sp_Curso_Insertar @nivel_curso = 'Segundo Año', @codigo_interno_ciclo = 2;
EXEC sp_Curso_Insertar @nivel_curso = 'Primer Año', @codigo_interno_ciclo = 3;
EXEC sp_Curso_Insertar @nivel_curso = 'Segundo Año', @codigo_interno_ciclo = 3;
EXEC sp_Curso_Insertar @nivel_curso = 'Primer Año', @codigo_interno_ciclo = 4;
EXEC sp_Curso_Insertar @nivel_curso = 'Segundo Año', @codigo_interno_ciclo = 4;
EXEC sp_Curso_Insertar @nivel_curso = 'Primer Año', @codigo_interno_ciclo = 5;
GO

-- PROFESORES
USE InstitutoTECNIC;
GO
EXEC sp_Profesor_Insertar @cedula_profesor = '1-1001-0001', @nombre_profesor = 'José Angel', @apellido1_profesor = 'Jiménez', @apellido2_profesor = 'Torrentes', @correo_profesor = 'jose.jimenez@tecnic.cr', @telefono_profesor = '+506 8888-1001', @seguro_social_profesor = 1001, @direccion = 'Liberia';
EXEC sp_Profesor_Insertar @cedula_profesor = '1-1002-0002', @nombre_profesor = 'Raymond', @apellido1_profesor = 'Pérez', @apellido2_profesor = 'Meza', @correo_profesor = 'raymond.perez@tecnic.cr', @telefono_profesor = '+506 8888-1002', @seguro_social_profesor = 1002, @direccion = 'Nicoya';
EXEC sp_Profesor_Insertar @cedula_profesor = '1-1003-0003', @nombre_profesor = 'Alex', @apellido1_profesor = 'Villegas', @apellido2_profesor = 'Carranza', @correo_profesor = 'alex.villegas@tecnic.cr', @telefono_profesor = '+506 8888-1003', @seguro_social_profesor = 1003, @direccion = 'Sarapiquí';
EXEC sp_Profesor_Insertar @cedula_profesor = '1-1004-0004', @nombre_profesor = 'Gloriana', @apellido1_profesor = 'Peña', @apellido2_profesor = 'Ramírez', @correo_profesor = 'gloriana.pena@tecnic.cr', @telefono_profesor = '+506 8888-1004', @seguro_social_profesor = 1004, @direccion = 'Santa Cruz';
EXEC sp_Profesor_Insertar @cedula_profesor = '1-1005-0005', @nombre_profesor = 'Dinia', @apellido1_profesor = 'Medina', @apellido2_profesor = 'Baltodano', @correo_profesor = 'dinia.medina@tecnic.cr', @telefono_profesor = '+506 8888-1005', @seguro_social_profesor = 1005, @direccion = 'Heredia';
GO

-- AULAS
USE InstitutoTECNIC;
GO
EXEC sp_Aula_Insertar @numero_aula = 101, @nombre_aula = 'Laboratorio Redes', @capacidad = 25, @metros_cuadrados = 45.50, @tiene_proyector = 1, @id_sede = 1;
EXEC sp_Aula_Insertar @numero_aula = 102, @nombre_aula = 'Aula Teórica 1', @capacidad = 30, @metros_cuadrados = 40.00, @tiene_proyector = 1, @id_sede = 1;
EXEC sp_Aula_Insertar @numero_aula = 201, @nombre_aula = 'Aula Teórica 2', @capacidad = 20, @metros_cuadrados = 35.25, @tiene_proyector = 0, @id_sede = 1;
EXEC sp_Aula_Insertar @numero_aula = 103, @nombre_aula = 'Laboratorio Contabilidad', @capacidad = 25, @metros_cuadrados = 42.00, @tiene_proyector = 1, @id_sede = 2;
EXEC sp_Aula_Insertar @numero_aula = 104, @nombre_aula = 'Aula Diseño', @capacidad = 20, @metros_cuadrados = 38.00, @tiene_proyector = 0, @id_sede = 3;
EXEC sp_Aula_Insertar @numero_aula = 105, @nombre_aula = 'Laboratorio Software', @capacidad = 28, @metros_cuadrados = 44.00, @tiene_proyector = 1, @id_sede = 5;
GO

-- ASIGNATURAS (misma materia = mismo codigo_oficial; distinta seccion = otro profe)
USE InstitutoTECNIC;
GO
EXEC sp_Asignatura_Insertar @codigo_oficial = 'RED-101', @nombre_asignatura = 'Fundamentos de Redes', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 2, @id_aula = 1, @antiguedad_profesor = 4, @fecha_inicio_imparticion_profe = '2021-03-10', @fecha_fin_imparticion_profe = '2024-12-20';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'RED-201', @nombre_asignatura = 'Redes Avanzadas', @duracion_horas_asignatura = 100, @codigo_interno_profesor = 2, @id_aula = 1, @antiguedad_profesor = 1, @fecha_inicio_imparticion_profe = '2024-01-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'PRO-101', @nombre_asignatura = 'Lógica de Programación', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 1, @id_aula = 2, @antiguedad_profesor = 5, @fecha_inicio_imparticion_profe = '2020-01-15', @fecha_fin_imparticion_profe = '2023-12-20';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'PRO-201', @nombre_asignatura = 'Programación Orientada a Objetos', @duracion_horas_asignatura = 120, @codigo_interno_profesor = 1, @id_aula = 2, @antiguedad_profesor = 5, @fecha_inicio_imparticion_profe = '2020-01-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'CON-101', @nombre_asignatura = 'Contabilidad Básica', @duracion_horas_asignatura = 90, @codigo_interno_profesor = 4, @id_aula = 4, @antiguedad_profesor = 4, @fecha_inicio_imparticion_profe = '2021-08-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'CON-201', @nombre_asignatura = 'Contabilidad Avanzada', @duracion_horas_asignatura = 100, @codigo_interno_profesor = 4, @id_aula = 4, @antiguedad_profesor = 4, @fecha_inicio_imparticion_profe = '2021-08-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'DIS-101', @nombre_asignatura = 'Diseño Vectorial', @duracion_horas_asignatura = 70, @codigo_interno_profesor = 4, @id_aula = 5, @antiguedad_profesor = 0;
EXEC sp_Asignatura_Insertar @codigo_oficial = 'DIS-201', @nombre_asignatura = 'Diseño Publicitario', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 4, @id_aula = 5, @antiguedad_profesor = 0;
EXEC sp_Asignatura_Insertar @codigo_oficial = 'BAD-213', @nombre_asignatura = 'Bases de Datos', @duracion_horas_asignatura = 100, @codigo_interno_profesor = 3, @id_aula = 2, @antiguedad_profesor = 3, @fecha_inicio_imparticion_profe = '2022-02-01';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'WEB-301', @nombre_asignatura = 'Desarrollo Web', @duracion_horas_asignatura = 120, @codigo_interno_profesor = 1, @id_aula = 1, @antiguedad_profesor = 3, @fecha_inicio_imparticion_profe = '2022-01-10';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'ADM-101', @nombre_asignatura = 'Administración General', @duracion_horas_asignatura = 60, @codigo_interno_profesor = 5, @id_aula = 1, @antiguedad_profesor = 6, @fecha_inicio_imparticion_profe = '2019-01-10';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'BAD-213', @nombre_asignatura = 'Bases de Datos', @duracion_horas_asignatura = 100, @codigo_interno_profesor = 1, @id_aula = 5, @antiguedad_profesor = 5, @fecha_inicio_imparticion_profe = '2020-01-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'PRO-101', @nombre_asignatura = 'Lógica de Programación', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 3, @id_aula = 2, @antiguedad_profesor = 3, @fecha_inicio_imparticion_profe = '2022-02-01';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'RED-101', @nombre_asignatura = 'Fundamentos de Redes', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 3, @id_aula = 1, @antiguedad_profesor = 3, @fecha_inicio_imparticion_profe = '2022-06-01';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'ING-102', @nombre_asignatura = 'Inglés Técnico', @duracion_horas_asignatura = 60, @codigo_interno_profesor = 5, @id_aula = 2, @antiguedad_profesor = 6, @fecha_inicio_imparticion_profe = '2019-01-10';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'MAT-110', @nombre_asignatura = 'Matemática Aplicada', @duracion_horas_asignatura = 80, @codigo_interno_profesor = 2, @id_aula = 2, @antiguedad_profesor = 4, @fecha_inicio_imparticion_profe = '2021-03-10';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'ETG-105', @nombre_asignatura = 'Ética Profesional', @duracion_horas_asignatura = 40, @codigo_interno_profesor = 4, @id_aula = 3, @antiguedad_profesor = 4, @fecha_inicio_imparticion_profe = '2021-08-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'CYB-220', @nombre_asignatura = 'Ciberseguridad', @duracion_horas_asignatura = 90, @codigo_interno_profesor = 2, @id_aula = 1, @antiguedad_profesor = 1, @fecha_inicio_imparticion_profe = '2024-01-15';
EXEC sp_Asignatura_Insertar @codigo_oficial = 'SIS-315', @nombre_asignatura = 'Análisis de Sistemas', @duracion_horas_asignatura = 100, @codigo_interno_profesor = 1, @id_aula = 5, @antiguedad_profesor = 5, @fecha_inicio_imparticion_profe = '2020-01-15';
GO

-- ASIGNATURA-CICLO
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 1, @codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 2, @codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 14, @codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 16, @codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 18, @codigo_interno_ciclo = 1;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 5, @codigo_interno_ciclo = 2;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 6, @codigo_interno_ciclo = 2;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 17, @codigo_interno_ciclo = 2;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 7, @codigo_interno_ciclo = 3;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 8, @codigo_interno_ciclo = 3;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 3, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 4, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 9, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 10, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 12, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 13, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 19, @codigo_interno_ciclo = 4;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 11, @codigo_interno_ciclo = 5;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 15, @codigo_interno_ciclo = 5;
EXEC sp_AsignaturaCiclo_Insertar @codigo_interno_asignatura = 17, @codigo_interno_ciclo = 5;
GO

-- ASIGNATURA-CURSO
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 1, @id_curso = 1;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 2, @id_curso = 2;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 14, @id_curso = 1;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 16, @id_curso = 1;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 18, @id_curso = 2;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 5, @id_curso = 3;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 6, @id_curso = 4;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 17, @id_curso = 3;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 7, @id_curso = 5;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 8, @id_curso = 6;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 3, @id_curso = 7;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 4, @id_curso = 8;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 9, @id_curso = 7;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 10, @id_curso = 8;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 12, @id_curso = 7;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 13, @id_curso = 7;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 19, @id_curso = 8;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 11, @id_curso = 9;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 15, @id_curso = 9;
EXEC sp_AsignaturaCurso_Insertar @codigo_interno_asignatura = 17, @id_curso = 9;
GO

-- HORARIO (bloques)
USE InstitutoTECNIC;
GO
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '07:00', @hora_fin_bloque = '08:30', @dia_semana = 'Lunes', @num_bloque = 1;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '09:00', @hora_fin_bloque = '10:30', @dia_semana = 'Martes', @num_bloque = 2;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '07:00', @hora_fin_bloque = '08:30', @dia_semana = 'Miércoles', @num_bloque = 1;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '07:00', @hora_fin_bloque = '08:30', @dia_semana = 'Jueves', @num_bloque = 1;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '07:00', @hora_fin_bloque = '08:30', @dia_semana = 'Viernes', @num_bloque = 1;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '07:00', @hora_fin_bloque = '08:30', @dia_semana = 'Sábado', @num_bloque = 1;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '09:00', @hora_fin_bloque = '10:30', @dia_semana = 'Lunes', @num_bloque = 2;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '14:00', @hora_fin_bloque = '15:30', @dia_semana = 'Lunes', @num_bloque = 3;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '14:00', @hora_fin_bloque = '15:30', @dia_semana = 'Martes', @num_bloque = 3;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '14:00', @hora_fin_bloque = '15:30', @dia_semana = 'Miércoles', @num_bloque = 3;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '14:00', @hora_fin_bloque = '15:30', @dia_semana = 'Jueves', @num_bloque = 3;
EXEC sp_HorarioBloque_Insertar @hora_inicio_bloque = '09:00', @hora_fin_bloque = '10:30', @dia_semana = 'Viernes', @num_bloque = 2;
GO

-- HORARIO-ASIGNATURA
USE InstitutoTECNIC;
GO
EXEC sp_HorarioAsignatura_Asignar @id_horario = 1, @codigo_interno_asignatura = 4;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 2, @codigo_interno_asignatura = 10;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 3, @codigo_interno_asignatura = 2;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 4, @codigo_interno_asignatura = 9;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 5, @codigo_interno_asignatura = 5;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 6, @codigo_interno_asignatura = 11;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 7, @codigo_interno_asignatura = 13;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 8, @codigo_interno_asignatura = 12;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 9, @codigo_interno_asignatura = 15;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 10, @codigo_interno_asignatura = 14;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 11, @codigo_interno_asignatura = 18;
EXEC sp_HorarioAsignatura_Asignar @id_horario = 12, @codigo_interno_asignatura = 7;
GO

-- PRERREQUISITOS
USE InstitutoTECNIC;
GO
EXEC sp_Prerrequisito_Insertar @codigo_oficial_asignatura_prerequerida = 'PRO-101', @nombre_asignatura_prerequisito = 'Lógica de Programación';
EXEC sp_Prerrequisito_Insertar @codigo_oficial_asignatura_prerequerida = 'RED-101', @nombre_asignatura_prerequisito = 'Fundamentos de Redes';
EXEC sp_Prerrequisito_Insertar @codigo_oficial_asignatura_prerequerida = 'BAD-213', @nombre_asignatura_prerequisito = 'Bases de Datos';
GO

-- ASIGNATURA-PRERREQUISITO
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturaPrerrequisito_Asignar @codigo_interno_asignatura = 4, @id_prerrequisito = 1;
EXEC sp_AsignaturaPrerrequisito_Asignar @codigo_interno_asignatura = 2, @id_prerrequisito = 2;
EXEC sp_AsignaturaPrerrequisito_Asignar @codigo_interno_asignatura = 10, @id_prerrequisito = 3;
EXEC sp_AsignaturaPrerrequisito_Asignar @codigo_interno_asignatura = 19, @id_prerrequisito = 1;
EXEC sp_AsignaturaPrerrequisito_Asignar @codigo_interno_asignatura = 18, @id_prerrequisito = 2;
GO

-- ESTUDIANTES
USE InstitutoTECNIC;
GO
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0001-0001', @nombre_estudiante = 'Samir', @apellido1_estudiante = 'Campos', @apellido2_estudiante = 'Díaz', @seguro_social_estudiante = 2006, @correo_estudiante = 'samir.campos@est.tecnic.cr', @telefono_estudiante = '+506 7000-0001', @fecha_nacimiento = '2005-03-12', @fecha_ingreso = '2025-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0002-0002', @nombre_estudiante = 'Fátima', @apellido1_estudiante = 'Carrillo', @apellido2_estudiante = 'García', @seguro_social_estudiante = 2007, @correo_estudiante = 'fatima.carrillo@est.tecnic.cr', @telefono_estudiante = '+506 7000-0002', @fecha_nacimiento = '2006-05-20', @fecha_ingreso = '2025-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0003-0003', @nombre_estudiante = 'María del Mar', @apellido1_estudiante = 'Díaz', @apellido2_estudiante = 'Ruiz', @seguro_social_estudiante = 2008, @correo_estudiante = 'maria.diaz@est.tecnic.cr', @telefono_estudiante = '+506 7000-0003', @fecha_nacimiento = '2005-11-08', @fecha_ingreso = '2025-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0004-0004', @nombre_estudiante = 'Brayan José', @apellido1_estudiante = 'Pérez', @apellido2_estudiante = 'Balladares', @seguro_social_estudiante = 2009, @correo_estudiante = 'brayan.perez@est.tecnic.cr', @telefono_estudiante = '+506 7000-0004', @fecha_nacimiento = '2004-09-15', @fecha_ingreso = '2024-01-20';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0005-0005', @nombre_estudiante = 'Yeisson Alberto', @apellido1_estudiante = 'Villalobos', @apellido2_estudiante = 'Toruño', @seguro_social_estudiante = 2010, @correo_estudiante = 'yeisson.villalobos@est.tecnic.cr', @telefono_estudiante = '+506 7000-0005', @fecha_nacimiento = '2005-07-25', @fecha_ingreso = '2025-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0006-0006', @nombre_estudiante = 'Juanito', @apellido1_estudiante = 'Pérez', @apellido2_estudiante = 'González', @seguro_social_estudiante = 2011, @correo_estudiante = 'juanito.perez@est.tecnic.cr', @telefono_estudiante = '+506 7000-0006', @fecha_nacimiento = '2005-02-10', @fecha_ingreso = '2024-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0007-0007', @nombre_estudiante = 'Panchita', @apellido1_estudiante = 'Rodríguez', @apellido2_estudiante = 'Solano', @seguro_social_estudiante = 2012, @correo_estudiante = 'panchita.rodriguez@est.tecnic.cr', @telefono_estudiante = '+506 7000-0007', @fecha_nacimiento = '2006-07-18', @fecha_ingreso = '2025-01-15';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0008-0008', @nombre_estudiante = 'Pedrito', @apellido1_estudiante = 'Morales', @apellido2_estudiante = 'Chacón', @seguro_social_estudiante = 2013, @correo_estudiante = 'pedrito.morales@est.tecnic.cr', @telefono_estudiante = '+506 7000-0008', @fecha_nacimiento = '2004-11-25', @fecha_ingreso = '2024-01-20';
EXEC sp_Estudiante_Insertar @cedula_estudiante = '5-0009-0009', @nombre_estudiante = 'Alvarito', @apellido1_estudiante = 'Quesada', @apellido2_estudiante = 'Jiménez', @seguro_social_estudiante = 2014, @correo_estudiante = 'alvarito.quesada@est.tecnic.cr', @telefono_estudiante = '+506 7000-0009', @fecha_nacimiento = '2005-09-03', @fecha_ingreso = '2025-01-15';
GO

-- PERIODOS
USE InstitutoTECNIC;
GO
EXEC sp_Periodo_Insertar @nombre_periodo = 'I-2024', @annio = 2024;
EXEC sp_Periodo_Insertar @nombre_periodo = 'II-2024', @annio = 2024;
EXEC sp_Periodo_Insertar @nombre_periodo = 'I-2025', @annio = 2025;
EXEC sp_Periodo_Insertar @nombre_periodo = 'II-2025', @annio = 2025;
GO

-- NOTAS FINALES (historicas antes de matricular asignaturas con prerrequisito)
USE InstitutoTECNIC;
GO
EXEC sp_NotaFinal_Insertar @promedio_final = 85.50, @estado_nota = 'Aprobado', @id_estudiante = 1, @codigo_interno_asignatura = 3, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @promedio_final = 84.00, @estado_nota = 'Aprobado', @id_estudiante = 1, @codigo_interno_asignatura = 9, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @promedio_final = 78.00, @estado_nota = 'Aprobado', @id_estudiante = 2, @codigo_interno_asignatura = 1, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @promedio_final = 80.00, @estado_nota = 'Aprobado', @id_estudiante = 4, @codigo_interno_asignatura = 3, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @promedio_final = 90.00, @estado_nota = 'Aprobado', @id_estudiante = 6, @codigo_interno_asignatura = 3, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @promedio_final = 87.00, @estado_nota = 'Aprobado', @id_estudiante = 6, @codigo_interno_asignatura = 9, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @promedio_final = 91.00, @estado_nota = 'Aprobado', @id_estudiante = 6, @codigo_interno_asignatura = 13, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @promedio_final = 83.00, @estado_nota = 'Aprobado', @id_estudiante = 8, @codigo_interno_asignatura = 9, @id_periodo = 2;
GO

-- MATRICULAS (id_sede: 1=Liberia, 2=Nicoya, 3=Sarapiqui, 5=Heredia)
USE InstitutoTECNIC;
GO
EXEC sp_Matricula_Insertar @id_estudiante = 1, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 2, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 3, @id_sede = 2, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 4, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 5, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 6, @id_sede = 1, @fecha_matricula = '2024-02-01', @estado_matricula = 'Finalizada';
EXEC sp_Matricula_Insertar @id_estudiante = 6, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 7, @id_sede = 2, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 8, @id_sede = 3, @fecha_matricula = '2024-02-01', @estado_matricula = 'Finalizada';
EXEC sp_Matricula_Insertar @id_estudiante = 8, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
EXEC sp_Matricula_Insertar @id_estudiante = 9, @id_sede = 1, @fecha_matricula = '2025-02-01', @estado_matricula = 'Activa';
GO

-- ASIGNATURA-MATRICULA
USE InstitutoTECNIC;
GO
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 4, @id_matricula = 1;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 10, @id_matricula = 1;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 16, @id_matricula = 1;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 15, @id_matricula = 1;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 2, @id_matricula = 2;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 14, @id_matricula = 2;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 18, @id_matricula = 2;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 5, @id_matricula = 3;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 6, @id_matricula = 3;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 9, @id_matricula = 4;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 10, @id_matricula = 4;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 11, @id_matricula = 5;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 15, @id_matricula = 5;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 3, @id_matricula = 6;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 9, @id_matricula = 6;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 13, @id_matricula = 6;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 4, @id_matricula = 7;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 10, @id_matricula = 7;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 13, @id_matricula = 7;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 5, @id_matricula = 8;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 6, @id_matricula = 8;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 7, @id_matricula = 9;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 8, @id_matricula = 9;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 9, @id_matricula = 10;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 10, @id_matricula = 10;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 11, @id_matricula = 11;
EXEC sp_AsignaturaMatricula_Insertar @codigo_interno_asignatura = 15, @id_matricula = 11;
GO

-- NOTAS FINALES (restantes)
USE InstitutoTECNIC;
GO
EXEC sp_NotaFinal_Insertar @promedio_final = 92.00, @estado_nota = 'Aprobado', @id_estudiante = 3, @codigo_interno_asignatura = 5, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @promedio_final = 65.00, @estado_nota = 'Reprobado', @id_estudiante = 4, @codigo_interno_asignatura = 9, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @promedio_final = 88.00, @estado_nota = 'Aprobado', @id_estudiante = 4, @codigo_interno_asignatura = 9, @id_periodo = 2;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 5, @codigo_interno_asignatura = 11, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 6, @codigo_interno_asignatura = 4, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 6, @codigo_interno_asignatura = 10, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 7, @codigo_interno_asignatura = 5, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 7, @codigo_interno_asignatura = 6, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @promedio_final = 82.00, @estado_nota = 'Aprobado', @id_estudiante = 8, @codigo_interno_asignatura = 7, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @promedio_final = 79.00, @estado_nota = 'Aprobado', @id_estudiante = 8, @codigo_interno_asignatura = 8, @id_periodo = 1;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 8, @codigo_interno_asignatura = 9, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 8, @codigo_interno_asignatura = 10, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 9, @codigo_interno_asignatura = 11, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 1, @codigo_interno_asignatura = 16, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 2, @codigo_interno_asignatura = 14, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 2, @codigo_interno_asignatura = 18, @id_periodo = 3;
EXEC sp_NotaFinal_Insertar @estado_nota = 'En curso', @id_estudiante = 4, @codigo_interno_asignatura = 10, @id_periodo = 3;
GO

-- ASISTENCIA
USE InstitutoTECNIC;
GO
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-03 07:05', @estado_asistencia = 'Presente', @id_estudiante = 1, @codigo_interno_asignatura = 4;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-10 07:15', @estado_asistencia = 'Tardía', @id_estudiante = 1, @codigo_interno_asignatura = 4, @justificacion = 'Llegó 10 min tarde';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-05 07:00', @estado_asistencia = 'Presente', @id_estudiante = 2, @codigo_interno_asignatura = 2;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-12 07:00', @estado_asistencia = 'Ausente', @id_estudiante = 2, @codigo_interno_asignatura = 2, @justificacion = 'Sin justificación';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-04 07:00', @estado_asistencia = 'Presente', @id_estudiante = 3, @codigo_interno_asignatura = 5;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-06 07:00', @estado_asistencia = 'Justificada', @id_estudiante = 4, @codigo_interno_asignatura = 9, @justificacion = 'Cita médica';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-07 07:00', @estado_asistencia = 'Presente', @id_estudiante = 5, @codigo_interno_asignatura = 11;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-03 07:05', @estado_asistencia = 'Presente', @id_estudiante = 6, @codigo_interno_asignatura = 4;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-04 07:00', @estado_asistencia = 'Presente', @id_estudiante = 6, @codigo_interno_asignatura = 10;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-04 07:00', @estado_asistencia = 'Ausente', @id_estudiante = 7, @codigo_interno_asignatura = 5, @justificacion = 'Enfermo';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-06 07:00', @estado_asistencia = 'Presente', @id_estudiante = 8, @codigo_interno_asignatura = 9;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-07 07:10', @estado_asistencia = 'Tardía', @id_estudiante = 9, @codigo_interno_asignatura = 11, @justificacion = 'Problemas de bus';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-03 14:05', @estado_asistencia = 'Presente', @id_estudiante = 1, @codigo_interno_asignatura = 16;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-10 14:20', @estado_asistencia = 'Tardía', @id_estudiante = 1, @codigo_interno_asignatura = 16, @justificacion = 'Transporte';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-04 09:00', @estado_asistencia = 'Presente', @id_estudiante = 7, @codigo_interno_asignatura = 6;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-05 14:00', @estado_asistencia = 'Presente', @id_estudiante = 2, @codigo_interno_asignatura = 14;
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-06 14:00', @estado_asistencia = 'Ausente', @id_estudiante = 2, @codigo_interno_asignatura = 18, @justificacion = 'Permiso familiar';
EXEC sp_Asistencia_Insertar @fecha_asistencia = '2025-03-07 09:00', @estado_asistencia = 'Presente', @id_estudiante = 9, @codigo_interno_asignatura = 15;
GO

-- TUTORIA
USE InstitutoTECNIC;
GO
EXEC sp_Tutoria_Insertar @codigo_interno_profesor = 1, @id_curso = 7, @antiguedad_tutor = 3, @fecha_inicio_tutoria = '2022-02-01';
EXEC sp_Tutoria_Insertar @codigo_interno_profesor = 2, @id_curso = 1, @antiguedad_tutor = 2, @fecha_inicio_tutoria = '2023-02-01';
EXEC sp_Tutoria_Insertar @codigo_interno_profesor = 4, @id_curso = 3, @antiguedad_tutor = 4, @fecha_inicio_tutoria = '2021-02-01';
EXEC sp_Tutoria_Insertar @codigo_interno_profesor = 5, @id_curso = 9, @antiguedad_tutor = 6, @fecha_inicio_tutoria = '2019-02-01';
GO

-- USUARIOS
USE InstitutoTECNIC;
GO
EXEC sp_Usuario_Insertar @nombre_usuario = 'admin', @contrasena_plana = 'Admin#2026', @rol = 'Administrador';
EXEC sp_Usuario_Insertar @nombre_usuario = 'jose.jimenez', @contrasena_plana = 'Profe#2026', @rol = 'Profesor', @codigo_interno_profesor = 1;
EXEC sp_Usuario_Insertar @nombre_usuario = 'raymond.perez', @contrasena_plana = 'Profe#2026', @rol = 'Profesor', @codigo_interno_profesor = 2;
EXEC sp_Usuario_Insertar @nombre_usuario = 'alex.villegas', @contrasena_plana = 'Profe#2026', @rol = 'Profesor', @codigo_interno_profesor = 3;
EXEC sp_Usuario_Insertar @nombre_usuario = 'gloriana.pena', @contrasena_plana = 'Profe#2026', @rol = 'Profesor', @codigo_interno_profesor = 4;
EXEC sp_Usuario_Insertar @nombre_usuario = 'dinia.medina', @contrasena_plana = 'Profe#2026', @rol = 'Profesor', @codigo_interno_profesor = 5;
EXEC sp_Usuario_Insertar @nombre_usuario = 'samir.campos', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 1;
EXEC sp_Usuario_Insertar @nombre_usuario = 'fatima.carrillo', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 2;
EXEC sp_Usuario_Insertar @nombre_usuario = 'maria.diaz', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 3;
EXEC sp_Usuario_Insertar @nombre_usuario = 'brayan.perez', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 4;
EXEC sp_Usuario_Insertar @nombre_usuario = 'yeisson.villalobos', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 5;
EXEC sp_Usuario_Insertar @nombre_usuario = 'juanito.perez', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 6;
EXEC sp_Usuario_Insertar @nombre_usuario = 'panchita.rodriguez', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 7;
EXEC sp_Usuario_Insertar @nombre_usuario = 'pedrito.morales', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 8;
EXEC sp_Usuario_Insertar @nombre_usuario = 'alvarito.quesada', @contrasena_plana = 'Estu#2026', @rol = 'Estudiante', @id_estudiante = 9;
GO
