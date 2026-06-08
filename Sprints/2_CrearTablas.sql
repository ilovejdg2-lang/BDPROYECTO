/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 2/7
   TABLAS
   ============================================================================ */ 

-- TABLA: Sede (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Sede
(
    id_sede        INT           IDENTITY(1,1) NOT NULL,
    nombre_sede    NVARCHAR(100) NOT NULL,
    direccion_sede NVARCHAR(200) NULL,
    CONSTRAINT PK_Sede        PRIMARY KEY (id_sede),
    CONSTRAINT UQ_Sede_nombre UNIQUE (nombre_sede)
) ON FG_Academico;
GO
EXEC sp_help Sede;
GO

-- TABLA: Ciclo (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Ciclo
(
    codigo_interno_ciclo INT IDENTITY(1,1) NOT NULL,
    nombre_ciclo         NVARCHAR(100) NOT NULL,
    categoria            NVARCHAR(50)  NOT NULL,
    CONSTRAINT PK_Ciclo           PRIMARY KEY (codigo_interno_ciclo),
    CONSTRAINT UQ_Ciclo_nombre    UNIQUE (nombre_ciclo),
    CONSTRAINT CK_Ciclo_categoria CHECK (categoria IN (N'Grado Medio', N'Grado Superior', N'Bachillerato Técnico'))
) ON FG_Academico;
GO
EXEC sp_help Ciclo;
GO

-- TABLA: Curso (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Curso
(
    id_curso                INT IDENTITY(1,1) NOT NULL,
    codigo_interno_ciclo    INT NOT NULL,
    nombre_curso            NVARCHAR(50) NOT NULL,
    nivel                   INT NOT NULL,
    CONSTRAINT PK_Curso       PRIMARY KEY (id_curso),
    CONSTRAINT FK_Curso_Ciclo FOREIGN KEY (codigo_interno_ciclo) REFERENCES Ciclo(codigo_interno_ciclo),
    CONSTRAINT CK_Curso_nivel CHECK (nivel > 0),
    CONSTRAINT UQ_Curso_nivel UNIQUE (codigo_interno_ciclo, nivel)
) ON FG_Academico;
GO
EXEC sp_help Curso;
GO

-- TABLA: Asignatura (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Asignatura
(
    codigo_interno_asignatura INT           IDENTITY(1,1) NOT NULL,
    codigo_oficial            VARCHAR(20)   NOT NULL,
    nombre_asignatura         NVARCHAR(100) NOT NULL,
    duracion_horas            INT           NOT NULL,
    id_curso                  INT           NOT NULL,
    CONSTRAINT PK_Asignatura         PRIMARY KEY (codigo_interno_asignatura),
    CONSTRAINT UQ_Asignatura_oficial UNIQUE (codigo_oficial),
    CONSTRAINT FK_Asignatura_Curso   FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT CK_Asignatura_horas   CHECK (duracion_horas > 0)
) ON FG_Academico;
GO
EXEC sp_help Asignatura;
GO

-- TABLA: Profesor (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Profesor
(
    codigo_interno_profesor INT           IDENTITY(1,1) NOT NULL,
    cedula_profesor         VARCHAR(20)   NOT NULL,
    nombre_profesor         NVARCHAR(50) NOT NULL,
    apellido1_profesor         NVARCHAR(50) NOT NULL,
    apellido2_profesor         NVARCHAR(50) NOT NULL,
    correo_profesor         VARCHAR(100)  NULL,
    telefono_profesor       VARCHAR(20)   NULL,
    seguro_social_profesor           VARCHAR(50)   NULL,
    direccion_profesor      NVARCHAR(200) NULL,
    fecha_inicio_contrato   DATE          NOT NULL DEFAULT (GETDATE()),
    fecha_fin_contrato      DATE          NULL,
    CONSTRAINT PK_Profesor        PRIMARY KEY (codigo_interno_profesor),
    CONSTRAINT UQ_Profesor_cedula UNIQUE (cedula_profesor),
    CONSTRAINT CK_Profesor_fechas CHECK (fecha_fin_contrato IS NULL OR fecha_fin_contrato >= fecha_inicio_contrato)
) ON FG_Academico;
GO
EXEC sp_help Profesor;
GO

-- TABLA: Aula (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Aula
(
    numero_aula      INT           NOT NULL,
    id_sede          INT           NOT NULL,
    nombre_aula      NVARCHAR(100) NOT NULL,
    capacidad        INT           NOT NULL,
    metros_cuadrados DECIMAL(6,2)  NULL,
    tiene_proyector  BIT           NOT NULL DEFAULT (0),
    CONSTRAINT PK_Aula             PRIMARY KEY (numero_aula),
    CONSTRAINT FK_Aula_Sede        FOREIGN KEY (id_sede) REFERENCES Sede(id_sede),
    CONSTRAINT UQ_Aula_nombre_sede UNIQUE (id_sede, nombre_aula),
    CONSTRAINT CK_Aula_capacidad   CHECK (capacidad > 0),
    CONSTRAINT CK_Aula_metros      CHECK (metros_cuadrados IS NULL OR metros_cuadrados > 0)
) ON FG_Academico;
GO
EXEC sp_help Aula;
GO

-- TABLA: Estudiante (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Estudiante
(
    id_estudiante       INT           IDENTITY(1,1) NOT NULL,
    cedula_estudiante   VARCHAR(20)   NOT NULL,
    nombre_estudiante   NVARCHAR(50) NOT NULL,
    apellido1_estudiante        NVARCHAR(50) NOT NULL,
    apellido2_estudiante         NVARCHAR(50) NOT NULL,
    seguro_social_estudiante           VARCHAR(50)   NULL,
    correo_estudiante   VARCHAR(100)  NULL,
    telefono_estudiante VARCHAR(20)   NULL,
    fecha_nacimiento    DATE          NULL,
    fecha_ingreso       DATE          NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
    CONSTRAINT PK_Estudiante        PRIMARY KEY (id_estudiante),
    CONSTRAINT UQ_Estudiante_cedula UNIQUE (cedula_estudiante),
    CONSTRAINT CK_Est_fechas        CHECK (fecha_nacimiento IS NULL OR fecha_ingreso > fecha_nacimiento)
) ON FG_Academico;
GO
EXEC sp_help Estudiante;
GO

-- TABLA: ProfesorAsignatura (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE ProfesorAsignatura
(
    id_profesor_asignatura      INT IDENTITY(1,1) NOT NULL,
    codigo_interno_profesor     INT NOT NULL,
    codigo_interno_asignatura   INT NOT NULL,
    fecha_inicio                DATE NOT NULL,
    fecha_fin                   DATE NULL,
    antiguedad_asignatura       AS (DATEDIFF(YEAR, fecha_inicio, ISNULL(fecha_fin, GETDATE()))) PERSISTED,
    CONSTRAINT PK_ProfesorAsignatura PRIMARY KEY (id_profesor_asignatura),
    CONSTRAINT FK_PA_Profesor   FOREIGN KEY (codigo_interno_profesor) REFERENCES Profesor(codigo_interno_profesor),
    CONSTRAINT FK_PA_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT UQ_PA_par        UNIQUE (codigo_interno_profesor, codigo_interno_asignatura, fecha_inicio),
    CONSTRAINT CK_PA_fechas     CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
) ON FG_Operaciones;
GO
EXEC sp_help ProfesorAsignatura;
GO

-- TABLA: Tutoria (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Tutoria
(
    id_tutoria              INT  IDENTITY(1,1) NOT NULL,
    codigo_interno_profesor INT  NOT NULL,
    id_curso                INT  NOT NULL,
    antiguedad_tutor        INT  NOT NULL DEFAULT (0),
    fecha_inicio_tutoria    DATE NULL,
    fecha_fin_tutoria       DATE NULL,
    CONSTRAINT PK_Tutoria        PRIMARY KEY (id_tutoria),
    CONSTRAINT FK_Tutoria_Prof   FOREIGN KEY (codigo_interno_profesor) REFERENCES Profesor(codigo_interno_profesor),
    CONSTRAINT FK_Tutoria_Curso  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT UQ_Tutoria_curso  UNIQUE (id_curso),
    CONSTRAINT CK_Tutoria_antig  CHECK (antiguedad_tutor >= 0),
    CONSTRAINT CK_Tutoria_fechas CHECK (fecha_inicio_tutoria IS NULL OR fecha_fin_tutoria IS NULL OR fecha_fin_tutoria >= fecha_inicio_tutoria)
) ON FG_Operaciones;
GO
EXEC sp_help Tutoria;
GO

-- TABLA: Horario (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Horario
(
    id_horario              INT IDENTITY(1,1) NOT NULL,
    id_profesor_asignatura  INT NOT NULL,
    numero_aula             INT NOT NULL,
    id_curso                INT NOT NULL,
    dia_semana              NVARCHAR(15) NOT NULL,
    bloque                  INT NOT NULL,
    anio_academico          INT NOT NULL,
    CONSTRAINT PK_Horario              PRIMARY KEY (id_horario),
    CONSTRAINT FK_Horario_ProfAsig     FOREIGN KEY (id_profesor_asignatura) REFERENCES ProfesorAsignatura(id_profesor_asignatura),
    CONSTRAINT FK_Horario_Aula         FOREIGN KEY (numero_aula) REFERENCES Aula(numero_aula),
    CONSTRAINT FK_Horario_Curso        FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT CK_Horario_dia          CHECK (dia_semana IN (N'Lunes', N'Martes', N'Miércoles', N'Jueves', N'Viernes', N'Sábado')),
    CONSTRAINT CK_Horario_bloque       CHECK (bloque BETWEEN 1 AND 6),
    CONSTRAINT UQ_Horario_aula_slot    UNIQUE (numero_aula, dia_semana, bloque, anio_academico),
    CONSTRAINT UQ_Horario_prof_slot    UNIQUE (id_profesor_asignatura, dia_semana, bloque, anio_academico)
) ON FG_Operaciones;
GO
EXEC sp_help Horario;
GO

-- TABLA: Prerrequisito (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Prerrequisito
(
    id_prerrequisito                     INT IDENTITY(1,1) NOT NULL,
    codigo_interno_asignatura            INT NOT NULL,
    codigo_interno_asignatura_requerida  INT NOT NULL,
    estado                               NVARCHAR(20) NOT NULL DEFAULT (N'Activo'),
    CONSTRAINT PK_Prerrequisito     PRIMARY KEY (id_prerrequisito),
    CONSTRAINT FK_Prereq_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT FK_Prereq_Requerida  FOREIGN KEY (codigo_interno_asignatura_requerida) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT UQ_Prereq_par        UNIQUE (codigo_interno_asignatura, codigo_interno_asignatura_requerida),
    CONSTRAINT CK_Prereq_no_misma   CHECK (codigo_interno_asignatura <> codigo_interno_asignatura_requerida),
    CONSTRAINT CK_Prereq_estado     CHECK (estado IN (N'Activo', N'Inactivo', N'Eliminado'))
) ON FG_Operaciones;
GO
EXEC sp_help Prerrequisito;
GO

-- TABLA: Matricula (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Matricula
(
    id_matricula    INT          IDENTITY(1,1) NOT NULL,
    id_estudiante   INT          NOT NULL,
    periodo         NVARCHAR(50) NOT NULL DEFAULT (N'I-2026'),
    fecha_matricula DATE         NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
    estado          NVARCHAR(20) NOT NULL DEFAULT (N'Activa'),
    CONSTRAINT PK_Matricula       PRIMARY KEY (id_matricula),
    CONSTRAINT FK_Mat_Estudiante  FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT UQ_Mat_est_periodo UNIQUE (id_estudiante, periodo),
    CONSTRAINT CK_Mat_estado      CHECK (estado IN (N'Activa', N'Anulada', N'Finalizada'))
) ON FG_Operaciones;
GO
EXEC sp_help Matricula;
GO

-- TABLA: DetalleMatricula (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE DetalleMatricula
(
    id_detalle                   INT IDENTITY(1,1) NOT NULL,
    id_matricula                 INT NOT NULL,
    codigo_interno_asignatura    INT NOT NULL,
    CONSTRAINT PK_DetalleMatricula PRIMARY KEY (id_detalle),
    CONSTRAINT FK_Det_Matricula  FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula) ON DELETE CASCADE,
    CONSTRAINT FK_Det_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT UQ_Det_par        UNIQUE (id_matricula, codigo_interno_asignatura)
) ON FG_Operaciones;
GO
EXEC sp_help DetalleMatricula;
GO

-- TABLA: Asistencia (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Asistencia
(
    id_asistencia                  INT           IDENTITY(1,1) NOT NULL,
    id_estudiante                  INT           NOT NULL,
    codigo_interno_asignatura      INT           NOT NULL,
    fecha                          DATE          NOT NULL,
    estado                         NVARCHAR(15)  NOT NULL,
    observaciones                  NVARCHAR(200) NULL,
    CONSTRAINT PK_Asistencia      PRIMARY KEY (id_asistencia),
    CONSTRAINT FK_Asis_Estudiante FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT FK_Asis_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT CK_Asis_estado     CHECK (estado IN (N'Presente', N'Ausente', N'Tardía', N'Justificada')),
    CONSTRAINT UQ_Asis_unica      UNIQUE (id_estudiante, codigo_interno_asignatura, fecha)
) ON FG_Operaciones;
GO
EXEC sp_help Asistencia;
GO

-- TABLA: HistorialAcademico (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE HistorialAcademico
(
    id_historial                 INT          IDENTITY(1,1) NOT NULL,
    id_estudiante                INT          NOT NULL,
    codigo_interno_asignatura    INT          NOT NULL,
    promedio_final               DECIMAL(5,2) NULL,
    estado                       NVARCHAR(20) NOT NULL,
    periodo                      NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Historial       PRIMARY KEY (id_historial),
    CONSTRAINT FK_Hist_Estudiante FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT FK_Hist_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT CK_Hist_promedio   CHECK (promedio_final IS NULL OR (promedio_final >= 0 AND promedio_final <= 100)),
    CONSTRAINT CK_Hist_estado     CHECK (estado IN (N'Aprobado', N'Reprobado', N'En curso')),
    CONSTRAINT CK_Hist_curso_promedio CHECK ((estado = N'En curso' AND promedio_final IS NULL) OR (estado IN (N'Aprobado', N'Reprobado') AND promedio_final IS NOT NULL)),
    CONSTRAINT UQ_Hist_unico      UNIQUE (id_estudiante, codigo_interno_asignatura, periodo)
) ON FG_Operaciones;
GO
EXEC sp_help HistorialAcademico;
GO

-- TABLA USUARIO 
USE InstitutoTECNIC;
GO
CREATE TABLE Usuario
(
    id_usuario     INT IDENTITY(1,1) NOT NULL,
    nombre_usuario NVARCHAR(50) NOT NULL,
    contrasena     VARCHAR(255) NOT NULL,
    rol            NVARCHAR(30) NOT NULL DEFAULT N'Usuario',
    correo         VARCHAR(100) NULL,
    activo         BIT NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT PK_Usuario PRIMARY KEY (id_usuario),
    CONSTRAINT UQ_Usuario_nombre UNIQUE (nombre_usuario),
    CONSTRAINT CK_Usuario_rol CHECK (rol IN (N'Administrador', N'Profesor', N'Estudiante', N'Usuario'))
);
GO

-- TABLA BITACORA
USE InstitutoTECNIC;
GO
CREATE TABLE Bitacora
(
    id_bitacora   INT IDENTITY(1,1) NOT NULL,
    id_usuario    INT NULL,
    accion        NVARCHAR(200) NOT NULL,
    fecha         DATETIME NOT NULL DEFAULT (GETDATE()),
    ip_equipo     VARCHAR(50) NULL,
    CONSTRAINT PK_Bitacora PRIMARY KEY (id_bitacora),
    CONSTRAINT FK_Bitacora_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
GO