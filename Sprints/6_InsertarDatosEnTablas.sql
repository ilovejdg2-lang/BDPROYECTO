/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 6/7
   INSERCION DE DATOS
   ============================================================================ */

-- SEDES
USE InstitutoTECNIC;
GO
INSERT INTO Sede (nombre_sede, direccion_sede) VALUES
(N'Sede Liberia', N'Liberia, Guanacaste'),
(N'Sede Nicoya', N'Nicoya, Guanacaste'),
(N'Sede Sarapiquí', N'Sarapiquí, Heredia'),
(N'Sede Santa Cruz', N'Santa Cruz, Guanacaste'),
(N'Sede Heredia', N'Heredia Centro');
GO

-- CICLOS
USE InstitutoTECNIC;
GO
INSERT INTO Ciclo (nombre_ciclo, categoria) VALUES
(N'Redes y Telecomunicaciones', N'Grado Superior'),
(N'Contabilidad', N'Grado Medio'),
(N'Diseño Gráfico', N'Bachillerato Técnico'),
(N'Desarrollo de Software', N'Grado Superior'),
(N'Administración de Empresas', N'Grado Medio');
GO

-- CURSOS
USE InstitutoTECNIC;
GO
INSERT INTO Curso (nivel_curso, codigo_interno_ciclo) VALUES
(N'Primer Año', 1),
(N'Segundo Año', 1),
(N'Primer Año', 2),
(N'Segundo Año', 2),
(N'Primer Año', 3),
(N'Segundo Año', 3),
(N'Primer Año', 4),
(N'Segundo Año', 4),
(N'Primer Año', 5);
GO

-- PROFESORES
USE InstitutoTECNIC;
GO
INSERT INTO Profesor (cedula_profesor, nombre_profesor, apellido1_profesor, apellido2_profesor, correo_profesor, telefono_profesor, seguro_social_profesor, direccion) VALUES
('1-1001-0001', N'José Angel', N'Jiménez', N'Torrentes', N'jose.jimenez@tecnic.cr', '+506 8888-1001', 'SS-001', N'Liberia'),
('1-1002-0002', N'Raymond', N'Pérez', N'Meza', N'raymond.perez@tecnic.cr', '+506 8888-1002', 'SS-002', N'Nicoya'),
('1-1003-0003', N'Alex', N'Villegas', N'Carranza', N'alex.villegas@tecnic.cr', '+506 8888-1003', 'SS-003', N'Sarapiquí'),
('1-1004-0004', N'Gloriana', N'Peña', N'Ramírez', N'gloriana.pena@tecnic.cr', '+506 8888-1004', 'SS-004', N'Santa Cruz'),
('1-1005-0005', N'Dinia', N'Medina', N'Baltodano', N'dinia.medina@tecnic.cr', '+506 8888-1005', 'SS-005', N'Heredia');
GO

-- AULAS
USE InstitutoTECNIC;
GO
INSERT INTO Aula (numero_aula, nombre_aula, capacidad, metros_cuadrados, tiene_proyector, id_sede) VALUES
(101, N'Laboratorio Redes', 25, 45.50, 1, 1),
(102, N'Aula Teórica 1', 30, 40.00, 1, 1),
(201, N'Aula Teórica 2', 20, 35.25, 0, 1),
(103, N'Laboratorio Contabilidad', 25, 42.00, 1, 2),
(104, N'Aula Diseño', 20, 38.00, 0, 3);
GO

-- ASIGNATURAS
USE InstitutoTECNIC;
GO
INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas_asignatura, antiguedad_profesor, fecha_inicio_imparticion_profe, fecha_fin_imparticion_profe, codigo_interno_profesor, id_aula) VALUES
('OF-RED01', N'Fundamentos de Redes', 80,  4, '2021-03-10', '2024-12-20', 2, 1),
('OF-RED02', N'Redes Avanzadas', 100, 1, '2024-01-15', NULL,         2, 1),
('OF-PRO01', N'Lógica de Programación', 80, 5, '2020-01-15', '2023-12-20', 1, 2),
('OF-PRO02', N'Programación Orientada a Objetos', 120, 5, '2020-01-15', NULL, 1, 2),
('OF-CON01', N'Contabilidad Básica', 90,  4, '2021-08-15', NULL,         4, 4),
('OF-CON02', N'Contabilidad Avanzada', 100, 4, '2021-08-15', NULL,         4, 4),
('OF-DIS01', N'Diseño Vectorial', 70,  0, NULL,         NULL,         4, 5),
('OF-DIS02', N'Diseño Publicitario', 80,  0, NULL,         NULL,         4, 5),
('OF-SOF01', N'Bases de Datos', 100, 3, '2022-02-01', NULL,         3, 2),
('OF-SOF02', N'Desarrollo Web', 120, 3, '2022-01-10', NULL,         1, 1),
('OF-ADM01', N'Administración General', 60, 6, '2019-01-10', NULL,         5, 1);
GO

-- ASIGNATURA-CICLO
USE InstitutoTECNIC;
GO
INSERT INTO AsignaturaCiclo (codigo_interno_asignatura, codigo_interno_ciclo) VALUES
(1, 1), (2, 1),
(5, 2), (6, 2),
(7, 3), (8, 3),
(3, 4), (4, 4), (9, 4), (10, 4),
(11, 5);
GO

-- ASIGNATURA-CURSO
USE InstitutoTECNIC;
GO
INSERT INTO AsignaturaCurso (codigo_interno_asignatura, id_curso) VALUES
(1, 1), (2, 2),
(5, 3), (6, 4),
(7, 5), (8, 6),
(3, 7), (4, 8), (9, 7), (10, 8),
(11, 9);
GO

-- HORARIO
USE InstitutoTECNIC;
GO
INSERT INTO Horario (hora_inicio_bloque, hora_fin_bloque, dia_semana, num_bloque) VALUES
('07:00', '08:30', N'Lunes',     1),
('09:00', '10:30', N'Martes',    2),
('07:00', '08:30', N'Miércoles', 1),
('07:00', '08:30', N'Jueves',    1),
('07:00', '08:30', N'Viernes',   1),
('07:00', '08:30', N'Sábado',    1);
GO

-- HORARIO-ASIGNATURA
USE InstitutoTECNIC;
GO
INSERT INTO HorarioAsignatura (id_horario, codigo_interno_asignatura) VALUES
(1, 4),
(2, 10),
(3, 2),
(4, 9),
(5, 5),
(6, 11);
GO

-- PRERREQUISITOS
USE InstitutoTECNIC;
GO
INSERT INTO Prerrequisito (codigo_oficial_asignatura_prerequerida, estado_prerrequisito, nombre_asignatura_prerequisito) VALUES
('OF-PRO01', N'Activo', N'Lógica de Programación'),
('OF-RED01', N'Activo', N'Fundamentos de Redes'),
('OF-SOF01', N'Activo', N'Bases de Datos');
GO

-- ASIGNATURA-PRERREQUISITO
USE InstitutoTECNIC;
GO
INSERT INTO AsignaturaPrerrequisito (codigo_interno_asignatura, id_prerrequisito) VALUES
(4, 1),
(2, 2),
(10, 3);
GO

-- ESTUDIANTES
USE InstitutoTECNIC;
GO
INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, apellido1_estudiante, apellido2_estudiante, seguro_social_estudiante, correo_estudiante, telefono_estudiante, fecha_nacimiento, fecha_ingreso) VALUES
('5-0001-0001', N'Samir', N'Campos', N'Díaz', 'SS-006', N'samir.campos@est.tecnic.cr', '+506 7000-0001', '2005-03-12', '2025-01-15'),
('5-0002-0002', N'Fátima', N'Carrillo', N'García', 'SS-007', N'fatima.carrillo@est.tecnic.cr', '+506 7000-0002', '2006-05-20', '2025-01-15'),
('5-0003-0003', N'María del Mar', N'Díaz', N'Ruiz', 'SS-008', N'maria.diaz@est.tecnic.cr', '+506 7000-0003', '2005-11-08', '2025-01-15'),
('5-0004-0004', N'Brayan José', N'Pérez', N'Balladares', 'SS-009', N'brayan.perez@est.tecnic.cr', '+506 7000-0004', '2004-09-15', '2024-01-20'),
('5-0005-0005', N'Yeisson Alberto', N'Villalobos', N'Toruño', 'SS-010', N'yeisson.villalobos@est.tecnic.cr', '+506 7000-0005', '2005-07-25', '2025-01-15'),
('5-0006-0006', N'Juanito', N'Pérez', N'González', 'SS-011', N'juanito.perez@est.tecnic.cr', '+506 7000-0006', '2005-02-10', '2024-01-15'),
('5-0007-0007', N'Panchita', N'Rodríguez', N'Solano', 'SS-012', N'panchita.rodriguez@est.tecnic.cr', '+506 7000-0007', '2006-07-18', '2025-01-15'),
('5-0008-0008', N'Pedrito', N'Morales', N'Chacón', 'SS-013', N'pedrito.morales@est.tecnic.cr', '+506 7000-0008', '2004-11-25', '2024-01-20'),
('5-0009-0009', N'Alvarito', N'Quesada', N'Jiménez', 'SS-014', N'alvarito.quesada@est.tecnic.cr', '+506 7000-0009', '2005-09-03', '2025-01-15');
GO

-- PERIODOS
USE InstitutoTECNIC;
GO
INSERT INTO Periodo (nombre_periodo, annio) VALUES
(N'I-2024', 2024),
(N'II-2024', 2024),
(N'I-2025', 2025),
(N'II-2025', 2025);
GO

-- MATRICULAS
USE InstitutoTECNIC;
GO
INSERT INTO Matricula (fecha_matricula, estado_matricula, id_estudiante) VALUES
('2025-02-01', N'Activa', 1),
('2025-02-01', N'Activa', 2),
('2025-02-01', N'Activa', 3),
('2025-02-01', N'Activa', 4),
('2025-02-01', N'Activa', 5),
('2024-02-01', N'Finalizada', 6),
('2025-02-01', N'Activa', 6),
('2025-02-01', N'Activa', 7),
('2024-02-01', N'Finalizada', 8),
('2025-02-01', N'Activa', 8),
('2025-02-01', N'Activa', 9);
GO

-- ASIGNATURA-MATRICULA
USE InstitutoTECNIC;
GO
INSERT INTO AsignaturaMatricula (codigo_interno_asignatura, id_matricula) VALUES
(4, 1), (10, 1),
(2, 2),
(5, 3), (6, 3),
(9, 4),
(11, 5),
(3, 6), (9, 6),
(4, 7), (10, 7),
(5, 8), (6, 8),
(7, 9), (8, 9),
(9, 10), (10, 10),
(11, 11);
GO

-- NOTAS FINALES
USE InstitutoTECNIC;
GO
INSERT INTO NotaFinal (promedio_final, estado_nota, id_estudiante, codigo_interno_asignatura, id_periodo) VALUES
(85.50, N'Aprobado', 1, 3, 2),
(78.00, N'Aprobado', 2, 1, 2),
(92.00, N'Aprobado', 3, 5, 1),
(65.00, N'Reprobado', 4, 7, 1),
(88.00, N'Aprobado', 4, 7, 2),
(NULL,  N'En curso', 5, 11, 3),
(90.00, N'Aprobado', 6, 3, 1),
(87.00, N'Aprobado', 6, 9, 1),
(NULL,  N'En curso', 6, 4, 3),
(NULL,  N'En curso', 6, 10, 3),
(NULL,  N'En curso', 7, 5, 3),
(NULL,  N'En curso', 7, 6, 3),
(82.00, N'Aprobado', 8, 7, 1),
(79.00, N'Aprobado', 8, 8, 1),
(NULL,  N'En curso', 8, 9, 3),
(NULL,  N'En curso', 8, 10, 3),
(NULL,  N'En curso', 9, 11, 3);
GO

-- ASISTENCIA
USE InstitutoTECNIC;
GO
INSERT INTO Asistencia (fecha_asistencia, estado_asistencia, justificacion, id_estudiante, codigo_interno_asignatura) VALUES
('2025-03-03 07:05', N'Presente', NULL, 1, 4),
('2025-03-10 07:15', N'Tardía', N'Llegó 10 min tarde', 1, 4),
('2025-03-05 07:00', N'Presente', NULL, 2, 2),
('2025-03-12 07:00', N'Ausente', N'Sin justificación', 2, 2),
('2025-03-04 07:00', N'Presente', NULL, 3, 5),
('2025-03-06 07:00', N'Justificada', N'Cita médica', 4, 9),
('2025-03-07 07:00', N'Presente', NULL, 5, 11),
('2025-03-03 07:05', N'Presente', NULL, 6, 4),
('2025-03-04 07:00', N'Presente', NULL, 6, 10),
('2025-03-04 07:00', N'Ausente', N'Enfermo', 7, 5),
('2025-03-06 07:00', N'Presente', NULL, 8, 9),
('2025-03-07 07:10', N'Tardía', N'Problemas de bus', 9, 11);
GO

-- TUTORIA
USE InstitutoTECNIC;
GO
INSERT INTO Tutoria (antiguedad_tutor, fecha_inicio_tutoria, codigo_interno_profesor, id_curso) VALUES
(3, '2022-02-01', 1, 7),
(2, '2023-02-01', 2, 1),
(4, '2021-02-01', 4, 3),
(6, '2019-02-01', 5, 9);
GO

-- USUARIOS
USE InstitutoTECNIC;
GO
INSERT INTO Usuario (nombre_usuario, contrasena_usuario, rol, activo, id_estudiante, codigo_interno_profesor) VALUES
(N'admin', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Admin#2026'), 2), N'Administrador', 1, NULL, NULL),
(N'jose.jimenez', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 1, NULL, 1),
(N'raymond.perez', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 1, NULL, 2),
(N'alex.villegas', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 1, NULL, 3),
(N'gloriana.pena', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 1, NULL, 4),
(N'dinia.medina', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 1, NULL, 5),
(N'samir.campos', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 1, NULL),
(N'fatima.carrillo', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 2, NULL),
(N'maria.diaz', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 3, NULL),
(N'brayan.perez', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 4, NULL),
(N'yeisson.villalobos', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 5, NULL),
(N'juanito.perez', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 6, NULL),
(N'panchita.rodriguez', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 7, NULL),
(N'pedrito.morales', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 8, NULL),
(N'alvarito.quesada', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 1, 9, NULL);
GO
