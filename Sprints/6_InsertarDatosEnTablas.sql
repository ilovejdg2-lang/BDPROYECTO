/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 6/7
   INSERCION DE DATOS
   ============================================================================ */

-- USUARIOS
USE InstitutoTECNIC;
GO
INSERT INTO Usuario (nombre_usuario, contrasena, rol, correo, id_profesor, id_estudiante) VALUES
(N'admin', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Admin#2026'), 2), N'Administrador', 'admin@tecnic.cr', NULL, NULL),
(N'jose.jimenez', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 'jose.jimenez@tecnic.cr', 1, NULL),
(N'raymond.perez', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 'raymond.perez@tecnic.cr', 2, NULL),
(N'alex.villegas', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 'alex.villegas@tecnic.cr', 3, NULL),
(N'gloriana.pena', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 'gloriana.pena@tecnic.cr', 4, NULL),
(N'dinia.medina', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Profe#2026'), 2), N'Profesor', 'dinia.medina@tecnic.cr', 5, NULL),
(N'samir.campos', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'samir.campos@est.tecnic.cr', NULL, 1),
(N'fatima.carrillo', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'fatima.carrillo@est.tecnic.cr', NULL, 2),
(N'maria.diaz', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'maria.diaz@est.tecnic.cr', NULL, 3),
(N'brayan.perez', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'brayan.perez@est.tecnic.cr', NULL, 4),
(N'yeisson.villalobos', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'yeisson.villalobos@est.tecnic.cr', NULL, 5),
(N'juanito.perez', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'juanito.perez@est.tecnic.cr', NULL, 6),
(N'panchita.rodriguez', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'panchita.rodriguez@est.tecnic.cr', NULL, 7),
(N'pedrito.morales', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'pedrito.morales@est.tecnic.cr', NULL, 8),
(N'alvarito.quesada', CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', 'Estu#2026'), 2), N'Estudiante', 'alvarito.quesada@est.tecnic.cr', NULL, 9);
GO

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
INSERT INTO Curso (codigo_interno_ciclo, nombre_curso, nivel) VALUES
(1, N'Primer Año', 1),
(1, N'Segundo Año', 2),
(2, N'Primer Año', 1),
(2, N'Segundo Año', 2),
(3, N'Primer Año', 1),
(3, N'Segundo Año', 2),
(4, N'Primer Año', 1),
(4, N'Segundo Año', 2),
(5, N'Primer Año', 1);
GO

-- ASIGNATURAS
USE InstitutoTECNIC;
GO
INSERT INTO Asignatura (codigo_oficial, nombre_asignatura, duracion_horas, id_curso) VALUES
('OF-RED01', N'Fundamentos de Redes', 80, 1),
('OF-RED02', N'Redes Avanzadas', 100, 2),
('OF-PRO01', N'Lógica de Programación', 80, 7),
('OF-PRO02', N'Programación Orientada a Objetos', 120, 8),
('OF-CON01', N'Contabilidad Básica', 90, 3),
('OF-CON02', N'Contabilidad Avanzada', 100, 4),
('OF-DIS01', N'Diseño Vectorial', 70, 5),
('OF-DIS02', N'Diseño Publicitario', 80, 6),
('OF-SOF01', N'Bases de Datos', 100, 7),
('OF-SOF02', N'Desarrollo Web', 120, 8),
('OF-ADM01', N'Administración General', 60, 9);
GO

-- PROFESORES
USE InstitutoTECNIC;
GO
INSERT INTO Profesor (cedula_profesor, nombre_profesor,apellido1_profesor,apellido2_profesor, correo_profesor, telefono_profesor, seguro_social_profesor, direccion_profesor, fecha_inicio_contrato) VALUES
('1-1001-0001', N'José Angel',  N'Jiménez', ´N'Torrentes', N'jose.jimenez@tecnic.cr', '+506 8888-1001', 'SS-001', N'Liberia', '2020-01-15'),
('1-1002-0002', N'Raymond', N'Pérez', N'Meza', N'raymond.perez@tecnic.cr', '+506 8888-1002', 'SS-002', N'Nicoya', '2021-03-10'),
('1-1003-0003', N'Alex', N'Villegas', N'Carranza', N'alex.villegas@tecnic.cr', '+506 8888-1003', 'SS-003', N'Sarapiquí', '2022-02-01'),
('1-1004-0004', N'Gloriana',N'Peña',N'Ramírez', N'gloriana.pena@tecnic.cr', '+506 8888-1004', 'SS-004', N'Santa Cruz', '2021-08-15'),
('1-1005-0005', N'Dinia',N'Medina', N'Baltodano', N'dinia.medina@tecnic.cr', '+506 8888-1005', 'SS-005', N'Heredia', '2019-01-10');
GO

-- PROFESORASIGNATURA
USE InstitutoTECNIC;
GO
INSERT INTO ProfesorAsignatura (codigo_interno_profesor, codigo_interno_asignatura, fecha_inicio, fecha_fin) VALUES
(1, 3, '2020-01-15', '2023-12-20'),
(1, 4, '2020-01-15', NULL),
(1, 10, '2022-01-10', NULL),
(2, 1, '2021-03-10', '2024-12-20'),
(2, 2, '2024-01-15', NULL),
(3, 9, '2022-02-01', NULL),
(4, 5, '2021-08-15', NULL),
(4, 6, '2021-08-15', NULL),
(5, 11, '2019-01-10', NULL);
GO

-- AULAS
USE InstitutoTECNIC;
GO
INSERT INTO Aula (numero_aula, id_sede, nombre_aula, capacidad, metros_cuadrados, tiene_proyector) VALUES
(101, 1, N'Laboratorio Redes', 25, 45.50, 1),
(102, 1, N'Aula Teórica 1', 30, 40.00, 1),
(201, 1, N'Aula Teórica 2', 20, 35.25, 0),
(103, 2, N'Laboratorio Contabilidad', 25, 42.00, 1),
(104, 3, N'Aula Diseño', 20, 38.00, 0);
GO

-- ESTUDIANTES
USE InstitutoTECNIC;
GO
INSERT INTO Estudiante (cedula_estudiante, nombre_estudiante, apellido1_estudiante,apellido2_estudiante,seguro_social_estudiante, correo_estudiante, telefono_estudiante, fecha_nacimiento, fecha_ingreso) VALUES
('5-0001-0001', N'Samir', N'Campos', N'Díaz','SS-006' N'samir.campos@est.tecnic.cr', '+506 7000-0001', '2005-03-12', '2025-01-15'),
('5-0002-0002', N'Fátima', N'Carrillo', N'García','SS-007' N'fatima.carrillo@est.tecnic.cr', '+506 7000-0002', '2006-05-20', '2025-01-15'),
('5-0003-0003', N'María del Mar',N'Díaz',N'Ruiz','SS-008', N'maria.diaz@est.tecnic.cr', '+506 7000-0003', '2005-11-08', '2025-01-15'),
('5-0004-0004', N'Brayan José',N'Pérez', N'Balladares','SS-009' N'brayan.perez@est.tecnic.cr', '+506 7000-0004', '2004-09-15', '2024-01-20'),
('5-0005-0005', N'Yeisson Alberto',N'Villalobos',N'Toruño','SS-010' N'yeisson.villalobos@est.tecnic.cr', '+506 7000-0005', '2005-07-25', '2025-01-15'),
('5-0006-0006', N'Juanito',N'Pérez',N'González', 'SS-011', N'juanito.perez@est.tecnic.cr', '+506 7000-0006', '2005-02-10', '2024-01-15'),
('5-0007-0007', N'Panchita',N'Rodríguez',N'Solano', 'SS-012', N'panchita.rodriguez@est.tecnic.cr', '+506 7000-0007', '2006-07-18', '2025-01-15'),
('5-0008-0008', N'Pedrito',N'Morales',N'Chacón','SS-013', N'pedrito.morales@est.tecnic.cr', '+506 7000-0008', '2004-11-25', '2024-01-20'),
('5-0009-0009', N'Alvarito',N'Quesada', N'Jiménez', 'SS-014', N'alvarito.quesada@est.tecnic.cr', '+506 7000-0009', '2005-09-03', '2025-01-15');
GO

-- TUTORIA
USE InstitutoTECNIC;
GO
INSERT INTO Tutoria (codigo_interno_profesor, id_curso, antiguedad_tutor, fecha_inicio_tutoria) VALUES
(1, 7, 3, '2022-02-01'),
(2, 1, 2, '2023-02-01'),
(4, 3, 4, '2021-02-01'),
(5, 9, 6, '2019-02-01');
GO

-- HORARIO
USE InstitutoTECNIC;
GO
INSERT INTO Horario (id_profesor_asignatura, numero_aula, id_curso, dia_semana, bloque, anio_academico) VALUES
(2, 101, 8, N'Lunes', 1, 2025),
(3, 102, 8, N'Martes', 2, 2025),
(5, 101, 2, N'Miércoles', 1, 2025),
(6, 102, 7, N'Jueves', 1, 2025),
(7, 103, 3, N'Viernes', 1, 2025),
(9, 101, 9, N'Sábado', 1, 2025);
GO

-- PRERREQUISITO
USE InstitutoTECNIC;
GO
INSERT INTO Prerrequisito (codigo_interno_asignatura, codigo_interno_asignatura_requerida, estado) VALUES
(4, 3, N'Activo'),
(2, 1, N'Activo'),
(10, 9, N'Activo');
GO

-- MATRICULA
USE InstitutoTECNIC;
GO
INSERT INTO Matricula (id_estudiante, periodo, fecha_matricula, estado) VALUES
(1, N'I-2025', '2025-02-01', N'Activa'),
(2, N'I-2025', '2025-02-01', N'Activa'),
(3, N'I-2025', '2025-02-01', N'Activa'),
(4, N'I-2025', '2025-02-01', N'Activa'),
(5, N'I-2025', '2025-02-01', N'Activa'),
(6, N'I-2024', '2024-02-01', N'Finalizada'),
(6, N'I-2025', '2025-02-01', N'Activa'),
(7, N'I-2025', '2025-02-01', N'Activa'),
(8, N'I-2024', '2024-02-01', N'Finalizada'),
(8, N'I-2025', '2025-02-01', N'Activa'),
(9, N'I-2025', '2025-02-01', N'Activa');
GO

-- DETALLE MATRICULA
USE InstitutoTECNIC;
GO
INSERT INTO DetalleMatricula (id_matricula, codigo_interno_asignatura) VALUES
(1, 4), (1, 10),
(2, 2),
(3, 5), (3, 6),
(4, 9),
(5, 11),
(6, 3), (6, 9),
(7, 4), (7, 10),
(8, 5), (8, 6),
(9, 7), (9, 8),
(10, 9), (10, 10),
(11, 11);
GO

-- ASISTENCIA
USE InstitutoTECNIC;
GO
INSERT INTO Asistencia (id_estudiante, codigo_interno_asignatura, fecha, estado, observaciones) VALUES
(1, 4, '2025-03-03', N'Presente', NULL),
(1, 4, '2025-03-10', N'Tardía', N'Llegó 10 min tarde'),
(2, 2, '2025-03-05', N'Presente', NULL),
(2, 2, '2025-03-12', N'Ausente', N'Sin justificación'),
(3, 5, '2025-03-04', N'Presente', NULL),
(4, 9, '2025-03-06', N'Justificada', N'Cita médica'),
(5, 11, '2025-03-07', N'Presente', NULL),
(6, 4, '2025-03-03', N'Presente', NULL),
(6, 10, '2025-03-04', N'Presente', NULL),
(7, 5, '2025-03-04', N'Ausente', N'Enfermo'),
(8, 9, '2025-03-06', N'Presente', NULL),
(9, 11, '2025-03-07', N'Tardía', N'Problemas de bus');
GO

-- HISTORIAL ACADEMICO
USE InstitutoTECNIC;
GO
INSERT INTO HistorialAcademico (id_estudiante, codigo_interno_asignatura, promedio_final, estado, periodo) VALUES
(1, 3, 85.50, N'Aprobado', N'II-2024'),
(2, 1, 78.00, N'Aprobado', N'II-2024'),
(3, 5, 92.00, N'Aprobado', N'I-2024'),
(4, 7, 65.00, N'Reprobado', N'I-2024'),
(4, 7, 88.00, N'Aprobado', N'II-2024'),
(5, 11, NULL, N'En curso', N'I-2025'),
(6, 3, 90.00, N'Aprobado', N'I-2024'),
(6, 9, 87.00, N'Aprobado', N'I-2024'),
(6, 4, NULL, N'En curso', N'I-2025'),
(6, 10, NULL, N'En curso', N'I-2025'),
(7, 5, NULL, N'En curso', N'I-2025'),
(7, 6, NULL, N'En curso', N'I-2025'),
(8, 7, 82.00, N'Aprobado', N'I-2024'),
(8, 8, 79.00, N'Aprobado', N'I-2024'),
(8, 9, NULL, N'En curso', N'I-2025'),
(8, 10, NULL, N'En curso', N'I-2025'),
(9, 11, NULL, N'En curso', N'I-2025');
GO