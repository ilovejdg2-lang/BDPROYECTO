/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 2/12
   TABLAS
   ============================================================================ */

-- TABLA: Sede (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Sede
(
    id_sede        INT           IDENTITY(1,1) NOT NULL,
    nombre_sede    VARCHAR(100) NOT NULL,
    direccion_sede VARCHAR(200) NOT NULL,
    CONSTRAINT PK_Sede        PRIMARY KEY (id_sede),
    CONSTRAINT UQ_Sede_nombre UNIQUE (nombre_sede)
) ON FG_Academico;
GO


-- TABLA: Aula (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Aula
(
    id_aula          INT           IDENTITY(1,1) NOT NULL,
    numero_aula      INT           NOT NULL,
    nombre_aula      VARCHAR(100) NOT NULL,
    capacidad        INT           NOT NULL,
    metros_cuadrados FLOAT  NOT NULL,
    tiene_proyector  BIT           NOT NULL DEFAULT (0),
    id_sede          INT           NOT NULL,
    CONSTRAINT PK_Aula             PRIMARY KEY (id_aula),
    CONSTRAINT UQ_Aula_nombre      UNIQUE (nombre_aula),
    CONSTRAINT UQ_Aula_numero_sede UNIQUE (id_sede, numero_aula),
    CONSTRAINT FK_Aula_Sede        FOREIGN KEY (id_sede) REFERENCES Sede(id_sede),
    CONSTRAINT CK_Aula_capacidad   CHECK (capacidad > 0),
    CONSTRAINT CK_Aula_metros      CHECK (metros_cuadrados > 0)
) ON FG_Academico;
GO

-- TABLA: Ciclo (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Ciclo
(
    codigo_interno_ciclo INT           IDENTITY(1,1) NOT NULL,
    nombre_ciclo         VARCHAR(100) NOT NULL,
    categoria            VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_Ciclo           PRIMARY KEY (codigo_interno_ciclo),
    CONSTRAINT UQ_Ciclo_nombre    UNIQUE (nombre_ciclo),
    CONSTRAINT CK_Ciclo_categoria CHECK (categoria IN ('Grado Medio', 'Grado Superior', 'Bachillerato Tecnico'))
) ON FG_Academico;
GO

-- TABLA: Curso (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Curso
(
    id_curso             INT IDENTITY(1,1) NOT NULL,
    nivel_curso          VARCHAR(25) NOT NULL,
    codigo_interno_ciclo INT NOT NULL,
    CONSTRAINT PK_Curso           PRIMARY KEY (id_curso),
    CONSTRAINT FK_Curso_Ciclo     FOREIGN KEY (codigo_interno_ciclo) REFERENCES Ciclo(codigo_interno_ciclo),
    CONSTRAINT UQ_Curso_nivel_ciclo UNIQUE (codigo_interno_ciclo, nivel_curso),
    CONSTRAINT CK_Curso_nivel       CHECK (nivel_curso IN ('Primer Año', 'Segundo Año', 'Tercer Año'))
) ON FG_Academico;
GO

-- TABLA: Usuario (FG_Seguridad)
USE InstitutoTECNIC;
GO
CREATE TABLE Usuario
(
    id_usuario         INT IDENTITY(1,1) NOT NULL,
    nombre_usuario     VARCHAR(20)  NOT NULL,
    correo_usuario     VARCHAR(100) NOT NULL,
    contrasena_usuario VARCHAR(255) NOT NULL,
    rol                VARCHAR(25)  NOT NULL DEFAULT ('Usuario'),
    activo             BIT          NOT NULL DEFAULT (1),
    fecha_creacion     DATETIME     NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT PK_Usuario        PRIMARY KEY (id_usuario),
    CONSTRAINT UQ_Usuario_nombre UNIQUE (nombre_usuario),
    CONSTRAINT UQ_Usuario_correo UNIQUE (correo_usuario),
    CONSTRAINT CK_Usuario_rol    CHECK (rol IN ('Administrador', 'Profesor', 'Estudiante', 'Usuario'))
) ON FG_Seguridad;
GO

-- TABLA: Bitacora (FG_Seguridad)
USE InstitutoTECNIC;
GO
CREATE TABLE Bitacora
(
    id_bitacora    INT IDENTITY(1,1) NOT NULL,
    accion         VARCHAR(200) NOT NULL,
    fecha_bitacora DATETIME     NOT NULL DEFAULT (GETDATE()),
    ip_equipo      VARCHAR(50)  NULL,
    id_usuario     INT          NOT NULL,
    CONSTRAINT PK_Bitacora PRIMARY KEY (id_bitacora),
    CONSTRAINT FK_Bitacora_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
) ON FG_Seguridad;
GO

-- TABLA: Profesor (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Profesor
(
    codigo_interno_profesor INT           IDENTITY(1,1) NOT NULL,
    cedula_profesor         VARCHAR(20)   NOT NULL,
    nombre_profesor         VARCHAR(50)  NOT NULL,
    apellido1_profesor      VARCHAR(50)  NOT NULL,
    apellido2_profesor      VARCHAR(50)  NULL,
    telefono_profesor       VARCHAR(20)   NULL,
    seguro_social_profesor  INT           NULL,
    direccion_profesor      VARCHAR(200) NULL,
    id_usuario              INT           NULL,
    CONSTRAINT PK_Profesor        PRIMARY KEY (codigo_interno_profesor),
    CONSTRAINT UQ_Profesor_cedula UNIQUE (cedula_profesor),
    CONSTRAINT UQ_Profesor_seguro  UNIQUE (seguro_social_profesor),
    CONSTRAINT FK_Profesor_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    CONSTRAINT CK_Profesor_cedula CHECK (
        cedula_profesor LIKE '[1-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
        OR cedula_profesor LIKE '[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]'
    )
) ON FG_Academico;
GO

-- TABLA: Periodo (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Periodo
(
    id_periodo     INT IDENTITY(1,1) NOT NULL,
    nombre_periodo VARCHAR(50) NOT NULL,
    annio          INT          NOT NULL,
    CONSTRAINT PK_Periodo        PRIMARY KEY (id_periodo),
    CONSTRAINT UQ_Periodo_nombre_annio UNIQUE (nombre_periodo, annio),
    CONSTRAINT CK_Periodo_annio    CHECK (annio >= 2000 AND annio <= 2100),
    CONSTRAINT CK_Periodo_nombre   CHECK (nombre_periodo IN ('I-Semestre', 'II-Semestre'))
) ON FG_Operaciones;
GO

-- TABLA: Asignatura (FG_Academico)
-- Instancia semestral: codigo_interno cambia cada periodo/aula.
-- codigo_oficial identifica la materia (MEP) para acumular antiguedad del profesor.
USE InstitutoTECNIC;
GO
CREATE TABLE Asignatura
(
    codigo_interno_asignatura INT           IDENTITY(1,1) NOT NULL,
    codigo_oficial              VARCHAR(20)   NOT NULL,
    nombre_asignatura           VARCHAR(100) NOT NULL,
    duracion_horas_asignatura   INT           NOT NULL,
    id_aula                     INT           NOT NULL,
    id_periodo                  INT           NOT NULL,
    CONSTRAINT PK_Asignatura          PRIMARY KEY (codigo_interno_asignatura),
    CONSTRAINT FK_Asignatura_Aula     FOREIGN KEY (id_aula) REFERENCES Aula(id_aula),
    CONSTRAINT FK_Asignatura_Periodo  FOREIGN KEY (id_periodo) REFERENCES Periodo(id_periodo),
    CONSTRAINT CK_Asignatura_horas    CHECK (duracion_horas_asignatura > 0)
) ON FG_Academico;
GO

-- TABLA: AsignaturaProfesor (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE AsignaturaProfesor
(
    id_asignatura_profesor    INT  IDENTITY(1,1) NOT NULL,
    codigo_interno_profesor   INT  NOT NULL,
    codigo_interno_asignatura INT  NOT NULL,
    antiguedad_profesor       INT  NULL, 
    fecha_inicio_imparticion  DATE NULL,
    fecha_fin_imparticion     DATE NULL,
    CONSTRAINT PK_AsignaturaProfesor  PRIMARY KEY (id_asignatura_profesor),
    CONSTRAINT FK_AP_Profesor         FOREIGN KEY (codigo_interno_profesor) REFERENCES Profesor(codigo_interno_profesor),
    CONSTRAINT FK_AP_Asignatura       FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT UQ_AP_par              UNIQUE (codigo_interno_profesor, codigo_interno_asignatura),
    CONSTRAINT UQ_AP_asignatura       UNIQUE (codigo_interno_asignatura),
    CONSTRAINT CK_AP_fechas           CHECK (fecha_fin_imparticion IS NULL OR fecha_inicio_imparticion IS NULL OR fecha_fin_imparticion >= fecha_inicio_imparticion),
    CONSTRAINT CK_AP_antiguedad       CHECK (antiguedad_profesor IS NULL OR antiguedad_profesor >= 0)
) ON FG_Academico;
GO

-- TABLA: BloqueHorario (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE BloqueHorario
(
    num_bloque         INT  NOT NULL,
    hora_inicio_bloque TIME NOT NULL,
    hora_fin_bloque    TIME NOT NULL,
    CONSTRAINT PK_BloqueHorario      PRIMARY KEY (num_bloque),
    CONSTRAINT CK_BloqueHorario_num  CHECK (num_bloque BETWEEN 1 AND 6),
    CONSTRAINT CK_BloqueHorario_horas CHECK (hora_fin_bloque > hora_inicio_bloque)
) ON FG_Operaciones;
GO

-- TABLA: Horario (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Horario
(
    id_horario         INT IDENTITY(1,1) NOT NULL,
    dia_semana         VARCHAR(15) NOT NULL,
    num_bloque         INT          NOT NULL,
    CONSTRAINT PK_Horario          PRIMARY KEY (id_horario),
    CONSTRAINT FK_Horario_Bloque   FOREIGN KEY (num_bloque) REFERENCES BloqueHorario(num_bloque),
    CONSTRAINT CK_Horario_dia      CHECK (dia_semana IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado')),
    CONSTRAINT UQ_Horario_slot     UNIQUE (dia_semana, num_bloque)
) ON FG_Operaciones;
GO

-- TABLA: HorarioAsignatura (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE HorarioAsignatura
(
    id_horario_asignatura     INT IDENTITY(1,1) NOT NULL,
    id_horario                INT NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    CONSTRAINT PK_HorarioAsignatura PRIMARY KEY (id_horario_asignatura),
    CONSTRAINT FK_HA_Horario          FOREIGN KEY (id_horario) REFERENCES Horario(id_horario),
    CONSTRAINT FK_HA_Asignatura       FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT UQ_HA_horario_asig     UNIQUE (id_horario, codigo_interno_asignatura)
) ON FG_Operaciones;
GO

-- TABLA: AsignaturaCiclo (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE AsignaturaCiclo
(
    id_asignatura_ciclo       INT IDENTITY(1,1) NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    codigo_interno_ciclo      INT NOT NULL,
    CONSTRAINT PK_AsignaturaCiclo PRIMARY KEY (id_asignatura_ciclo),
    CONSTRAINT FK_AC_Asignatura   FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT FK_AC_Ciclo        FOREIGN KEY (codigo_interno_ciclo) REFERENCES Ciclo(codigo_interno_ciclo),
    CONSTRAINT UQ_AC_par          UNIQUE (codigo_interno_asignatura, codigo_interno_ciclo)
) ON FG_Operaciones;
GO

-- TABLA: AsignaturaCurso (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE AsignaturaCurso
(
    id_asignatura_curso       INT IDENTITY(1,1) NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    id_curso                  INT NOT NULL,
    CONSTRAINT PK_AsignaturaCurso PRIMARY KEY (id_asignatura_curso),
    CONSTRAINT FK_AsigCur_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT FK_AsigCur_Curso      FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT UQ_AsigCur_par        UNIQUE (codigo_interno_asignatura, id_curso)
) ON FG_Operaciones;
GO

-- TABLA: Prerrequisito (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Prerrequisito
(
    id_prerrequisito                       INT IDENTITY(1,1) NOT NULL,
    codigo_oficial_asignatura_prerequerida VARCHAR(20)   NULL,
    estado_prerrequisito                   VARCHAR(20)  NOT NULL DEFAULT ('Activo'),
    nombre_asignatura_prerequisito         VARCHAR(100) NULL,
    CONSTRAINT PK_Prerrequisito     PRIMARY KEY (id_prerrequisito),
    CONSTRAINT CK_Prerrequisito_estado CHECK (estado_prerrequisito IN ('Activo', 'Inactivo', 'Eliminado'))
) ON FG_Operaciones;
GO

-- TABLA: AsignaturaPrerrequisito (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE AsignaturaPrerrequisito
(
    id_asignatura_prerrequisito INT IDENTITY(1,1) NOT NULL,
    codigo_interno_asignatura   INT NOT NULL,
    id_prerrequisito            INT NOT NULL,
    CONSTRAINT PK_AsignaturaPrerrequisito PRIMARY KEY (id_asignatura_prerrequisito),
    CONSTRAINT FK_APR_Asignatura            FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT FK_APR_Prerrequisito         FOREIGN KEY (id_prerrequisito) REFERENCES Prerrequisito(id_prerrequisito),
    CONSTRAINT UQ_APR_par                   UNIQUE (codigo_interno_asignatura, id_prerrequisito)
) ON FG_Operaciones;
GO

-- TABLA: Estudiante (FG_Academico)
USE InstitutoTECNIC;
GO
CREATE TABLE Estudiante
(
    id_estudiante            INT IDENTITY(1,1) NOT NULL,
    cedula_estudiante        VARCHAR(20)   NOT NULL,
    nombre_estudiante        VARCHAR(50)  NOT NULL,
    apellido1_estudiante     VARCHAR(50)  NOT NULL,
    apellido2_estudiante     VARCHAR(50)  NULL,
    telefono_estudiante      VARCHAR(20)   NULL,
    seguro_social_estudiante INT           NULL,
    fecha_nacimiento         DATE          NULL,
    fecha_ingreso            DATE          NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
    id_usuario               INT           NULL,
    CONSTRAINT PK_Estudiante        PRIMARY KEY (id_estudiante),
    CONSTRAINT UQ_Estudiante_cedula UNIQUE (cedula_estudiante),
    CONSTRAINT UQ_Estudiante_seguro  UNIQUE (seguro_social_estudiante),
    CONSTRAINT FK_Estudiante_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    CONSTRAINT CK_Est_cedula CHECK (
        cedula_estudiante LIKE '[1-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
        OR cedula_estudiante LIKE '[A-Z][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]'
    ),
    CONSTRAINT CK_Est_fechas CHECK (fecha_nacimiento IS NULL OR fecha_ingreso > fecha_nacimiento),
    CONSTRAINT CK_Est_edad_min CHECK (
        fecha_nacimiento IS NULL OR fecha_ingreso >= DATEADD(YEAR, 12, fecha_nacimiento)
    )
) ON FG_Academico;
GO

-- TABLA: Matricula (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Matricula
(
    id_matricula     INT IDENTITY(1,1) NOT NULL,
    fecha_matricula  DATETIME     NOT NULL DEFAULT (GETDATE()),
    estado_matricula VARCHAR(20) NOT NULL DEFAULT ('Activa'),
    id_estudiante    INT          NOT NULL,
    id_sede          INT          NOT NULL,
    CONSTRAINT PK_Matricula      PRIMARY KEY (id_matricula),
    CONSTRAINT FK_Mat_Estudiante FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT FK_Mat_Sede       FOREIGN KEY (id_sede) REFERENCES Sede(id_sede),
    CONSTRAINT CK_Mat_estado     CHECK (estado_matricula IN ('Activa', 'Anulada', 'Finalizada'))
) ON FG_Operaciones;
GO

-- TABLA: AsignaturaMatricula (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE AsignaturaMatricula
(
    id_asignatura_matricula   INT IDENTITY(1,1) NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    id_matricula              INT NOT NULL,
    CONSTRAINT PK_AsignaturaMatricula PRIMARY KEY (id_asignatura_matricula),
    CONSTRAINT FK_AM_Asignatura         FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT FK_AM_Matricula          FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula) ON DELETE CASCADE,
    CONSTRAINT UQ_AM_par                UNIQUE (id_matricula, codigo_interno_asignatura)
) ON FG_Operaciones;
GO

-- TABLA: NotaFinal (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE NotaFinal
(
    id_nota_final             INT IDENTITY(1,1) NOT NULL,
    promedio_final            FLOAT NULL,
    estado_nota               VARCHAR(20) NOT NULL DEFAULT ('En curso'),
    id_estudiante             INT NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    CONSTRAINT PK_NotaFinal       PRIMARY KEY (id_nota_final),
    CONSTRAINT FK_NF_Estudiante   FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT FK_NF_Asignatura   FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT CK_NF_promedio     CHECK (promedio_final IS NULL OR (promedio_final >= 0 AND promedio_final <= 100)),
    CONSTRAINT CK_NF_estado       CHECK (estado_nota IN ('Aprobado', 'Reprobado', 'En curso')),
    CONSTRAINT CK_NF_estado_prom  CHECK ((estado_nota = 'En curso' AND promedio_final IS NULL) OR (estado_nota IN ('Aprobado', 'Reprobado') AND promedio_final IS NOT NULL)),
    CONSTRAINT CK_NF_nota_minima  CHECK (
        estado_nota = 'En curso'
        OR (estado_nota = 'Aprobado' AND promedio_final >= 70)
        OR (estado_nota = 'Reprobado' AND promedio_final < 70)
    ),
    CONSTRAINT UQ_NF_unico        UNIQUE (id_estudiante, codigo_interno_asignatura)
) ON FG_Operaciones;
GO

-- TABLA: Asistencia (FG_Operaciones)
USE InstitutoTECNIC;
GO
CREATE TABLE Asistencia
(
    id_asistencia             INT IDENTITY(1,1) NOT NULL,
    fecha_asistencia          DATE     NOT NULL DEFAULT (GETDATE()),
    estado_asistencia         VARCHAR(15) NOT NULL DEFAULT ('Presente'),
    justificacion             VARCHAR(200) NULL,
    id_estudiante             INT NOT NULL,
    codigo_interno_asignatura INT NOT NULL,
    CONSTRAINT PK_Asistencia      PRIMARY KEY (id_asistencia),
    CONSTRAINT FK_Asis_Estudiante FOREIGN KEY (id_estudiante) REFERENCES Estudiante(id_estudiante),
    CONSTRAINT FK_Asis_Asignatura FOREIGN KEY (codigo_interno_asignatura) REFERENCES Asignatura(codigo_interno_asignatura),
    CONSTRAINT CK_Asis_estado     CHECK (estado_asistencia IN ('Presente', 'Ausente', 'Tardía', 'Justificada')),
    CONSTRAINT CK_Asis_justificacion CHECK (
        estado_asistencia <> 'Justificada'
        OR (justificacion IS NOT NULL AND LEN(RTRIM(justificacion)) > 0)
    ),
    CONSTRAINT CK_Asis_fecha      CHECK (fecha_asistencia <= CAST(GETDATE() AS DATE)),
    CONSTRAINT UQ_Asis_unica      UNIQUE (id_estudiante, codigo_interno_asignatura, fecha_asistencia)
) ON FG_Operaciones;
GO

-- TABLA: Tutoria (FG_Operaciones).
USE InstitutoTECNIC;
GO
CREATE TABLE Tutoria
(
    id_tutoria              INT  IDENTITY(1,1) NOT NULL,
    antiguedad_tutor        INT  NULL, 
    fecha_inicio_tutoria    DATE NULL,
    fecha_fin_tutoria       DATE NULL,
    codigo_interno_profesor INT  NOT NULL,
    id_curso                INT  NOT NULL,
    CONSTRAINT PK_Tutoria        PRIMARY KEY (id_tutoria),
    CONSTRAINT FK_Tutoria_Prof   FOREIGN KEY (codigo_interno_profesor) REFERENCES Profesor(codigo_interno_profesor),
    CONSTRAINT FK_Tutoria_Curso  FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT UQ_Tutoria_curso  UNIQUE (id_curso),
    CONSTRAINT CK_Tutoria_antig  CHECK (antiguedad_tutor IS NULL OR antiguedad_tutor >= 0),
    CONSTRAINT CK_Tutoria_fechas CHECK (fecha_inicio_tutoria IS NULL OR fecha_fin_tutoria IS NULL OR fecha_fin_tutoria >= fecha_inicio_tutoria)
) ON FG_Operaciones;
GO
