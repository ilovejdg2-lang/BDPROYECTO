/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 5/11
   TRIGGERS DE AUDITORIA Y REGLAS DE NEGOCIO
   ============================================================================ */

-- AUDITORIA SEDE

--Registrar insercion en Sede
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Sede_Insert ON Sede AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Sede';
END
GO

--Registrar actualizacion en Sede
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Sede_Update ON Sede AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Sede';
END
GO

--Registrar eliminacion en Sede
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Sede_Delete ON Sede AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Sede';
END
GO

-- AUDITORIA AULA

--Registrar insercion en Aula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Aula_Insert ON Aula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Aula';
END
GO

--Registrar actualizacion en Aula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Aula_Update ON Aula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Aula';
END
GO

--Registrar eliminacion en Aula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Aula_Delete ON Aula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Aula';
END
GO

-- AUDITORIA CICLO

--Registrar insercion en Ciclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Ciclo_Insert ON Ciclo AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Ciclo';
END
GO

--Registrar actualizacion en Ciclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Ciclo_Update ON Ciclo AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Ciclo';
END
GO

--Registrar eliminacion en Ciclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Ciclo_Delete ON Ciclo AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Ciclo';
END
GO

-- AUDITORIA CURSO

--Registrar insercion en Curso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Curso_Insert ON Curso AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Curso';
END
GO

--Registrar actualizacion en Curso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Curso_Update ON Curso AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Curso';
END
GO

--Registrar eliminacion en Curso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Curso_Delete ON Curso AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Curso';
END
GO

-- AUDITORIA USUARIO

--Registrar insercion en Usuario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Usuario_Insert ON Usuario AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Usuario';
END
GO

--Registrar actualizacion en Usuario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Usuario_Update ON Usuario AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Usuario';
END
GO

--Registrar eliminacion en Usuario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Usuario_Delete ON Usuario AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Usuario';
END
GO

-- AUDITORIA PROFESOR

--Registrar insercion en Profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_Insert ON Profesor AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Profesor';
END
GO

--Registrar actualizacion en Profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_Update ON Profesor AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Profesor';
END
GO

--Registrar eliminacion en Profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_Delete ON Profesor AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Profesor';
END
GO

-- AUDITORIA PERIODO

--Registrar insercion en Periodo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Periodo_Insert ON Periodo AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Periodo';
END
GO

--Registrar actualizacion en Periodo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Periodo_Update ON Periodo AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Periodo';
END
GO

--Registrar eliminacion en Periodo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Periodo_Delete ON Periodo AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Periodo';
END
GO

-- AUDITORIA ASIGNATURA

--Registrar insercion en Asignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asignatura_Insert ON Asignatura AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Asignatura';
END
GO

--Registrar actualizacion en Asignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asignatura_Update ON Asignatura AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Asignatura';
END
GO

--Registrar eliminacion en Asignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asignatura_Delete ON Asignatura AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Asignatura';
END
GO

-- AUDITORIA ASIGNATURAPROFESOR

--Registrar insercion en ProfesorAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_ProfesorAsignatura_Insert ON ProfesorAsignatura AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'ProfesorAsignatura';
END
GO

--Registrar actualizacion en ProfesorAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_ProfesorAsignatura_Update ON ProfesorAsignatura AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'ProfesorAsignatura';
END
GO

--Registrar eliminacion en ProfesorAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_ProfesorAsignatura_Delete ON ProfesorAsignatura AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'ProfesorAsignatura';
END
GO

-- AUDITORIA BLOQUEHORARIO

--Registrar insercion en BloqueHorario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_BloqueHorario_Insert ON BloqueHorario AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'BloqueHorario';
END
GO

--Registrar actualizacion en BloqueHorario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_BloqueHorario_Update ON BloqueHorario AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'BloqueHorario';
END
GO

--Registrar eliminacion en BloqueHorario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_BloqueHorario_Delete ON BloqueHorario AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'BloqueHorario';
END
GO

-- AUDITORIA HORARIO

--Registrar insercion en Horario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Horario_Insert ON Horario AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Horario';
END
GO

--Registrar actualizacion en Horario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Horario_Update ON Horario AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Horario';
END
GO

--Registrar eliminacion en Horario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Horario_Delete ON Horario AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Horario';
END
GO

-- AUDITORIA HORARIOASIGNATURA

--Registrar insercion en HorarioAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_HorarioAsignatura_Insert ON HorarioAsignatura AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'HorarioAsignatura';
END
GO

--Registrar actualizacion en HorarioAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_HorarioAsignatura_Update ON HorarioAsignatura AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'HorarioAsignatura';
END
GO

--Registrar eliminacion en HorarioAsignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_HorarioAsignatura_Delete ON HorarioAsignatura AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'HorarioAsignatura';
END
GO

-- AUDITORIA ASIGNATURACICLO

--Registrar insercion en AsignaturaCiclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCiclo_Insert ON AsignaturaCiclo AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'AsignaturaCiclo';
END
GO

--Registrar actualizacion en AsignaturaCiclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCiclo_Update ON AsignaturaCiclo AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'AsignaturaCiclo';
END
GO

--Registrar eliminacion en AsignaturaCiclo
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCiclo_Delete ON AsignaturaCiclo AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'AsignaturaCiclo';
END
GO

-- AUDITORIA ASIGNATURACURSO

--Registrar insercion en AsignaturaCurso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCurso_Insert ON AsignaturaCurso AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'AsignaturaCurso';
END
GO

--Registrar actualizacion en AsignaturaCurso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCurso_Update ON AsignaturaCurso AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'AsignaturaCurso';
END
GO

--Registrar eliminacion en AsignaturaCurso
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaCurso_Delete ON AsignaturaCurso AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'AsignaturaCurso';
END
GO

-- AUDITORIA PRERREQUISITO

--Registrar insercion en Prerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Prerrequisito_Insert ON Prerrequisito AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Prerrequisito';
END
GO

--Registrar actualizacion en Prerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Prerrequisito_Update ON Prerrequisito AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Prerrequisito';
END
GO

--Registrar eliminacion en Prerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Prerrequisito_Delete ON Prerrequisito AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Prerrequisito';
END
GO

-- AUDITORIA ASIGNATURAPRERREQUISITO

--Registrar insercion en AsignaturaPrerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaPrerrequisito_Insert ON AsignaturaPrerrequisito AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'AsignaturaPrerrequisito';
END
GO

--Registrar actualizacion en AsignaturaPrerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaPrerrequisito_Update ON AsignaturaPrerrequisito AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'AsignaturaPrerrequisito';
END
GO

--Registrar eliminacion en AsignaturaPrerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaPrerrequisito_Delete ON AsignaturaPrerrequisito AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'AsignaturaPrerrequisito';
END
GO

-- AUDITORIA ESTUDIANTE

--Registrar insercion en Estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_Insert ON Estudiante AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Estudiante';
END
GO

--Registrar actualizacion en Estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_Update ON Estudiante AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Estudiante';
END
GO

--Registrar eliminacion en Estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_Delete ON Estudiante AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Estudiante';
END
GO

-- AUDITORIA MATRICULA

--Registrar insercion en Matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Matricula_Insert ON Matricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Matricula';
END
GO

--Registrar actualizacion en Matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Matricula_Update ON Matricula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Matricula';
END
GO

--Registrar eliminacion en Matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Matricula_Delete ON Matricula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Matricula';
END
GO

-- AUDITORIA ASIGNATURAMATRICULA

--Registrar insercion en AsignaturaMatricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_Insert ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'AsignaturaMatricula';
END
GO

--Registrar actualizacion en AsignaturaMatricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_Update ON AsignaturaMatricula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'AsignaturaMatricula';
END
GO

--Registrar eliminacion en AsignaturaMatricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_Delete ON AsignaturaMatricula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'AsignaturaMatricula';
END
GO

-- AUDITORIA NOTAFINAL

--Registrar insercion en NotaFinal
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_NotaFinal_Insert ON NotaFinal AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'NotaFinal';
END
GO

--Registrar actualizacion en NotaFinal
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_NotaFinal_Update ON NotaFinal AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'NotaFinal';
END
GO

--Registrar eliminacion en NotaFinal
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_NotaFinal_Delete ON NotaFinal AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'NotaFinal';
END
GO

-- AUDITORIA ASISTENCIA

--Registrar insercion en Asistencia
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asistencia_Insert ON Asistencia AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Asistencia';
END
GO

--Registrar actualizacion en Asistencia
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asistencia_Update ON Asistencia AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Asistencia';
END
GO

--Registrar eliminacion en Asistencia
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asistencia_Delete ON Asistencia AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Asistencia';
END
GO

-- AUDITORIA TUTORIA

--Registrar insercion en Tutoria
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Tutoria_Insert ON Tutoria AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'INSERT', 'Tutoria';
END
GO

--Registrar actualizacion en Tutoria
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Tutoria_Update ON Tutoria AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'UPDATE', 'Tutoria';
END
GO

--Registrar eliminacion en Tutoria
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Tutoria_Delete ON Tutoria AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    EXEC dbo.sp_Bitacora_Registrar 'DELETE', 'Tutoria';
END
GO

-- REGLAS DE NEGOCIO

--Validar prerrequisitos al inscribir asignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_VerificaPrerrequisito
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        JOIN AsignaturaPrerrequisito ap ON ap.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN Prerrequisito pr ON pr.id_prerrequisito = ap.id_prerrequisito
        WHERE pr.estado_prerrequisito = N'Activo'
          AND NOT EXISTS (
            SELECT 1
            FROM NotaFinal nf
            JOIN Asignatura a ON a.codigo_interno_asignatura = nf.codigo_interno_asignatura
            WHERE nf.id_estudiante = m.id_estudiante
              AND a.codigo_oficial = pr.codigo_oficial_asignatura_prerequerida
              AND nf.estado_nota = N'Aprobado'
        )
    )
    BEGIN
        RAISERROR(N'No se puede matricular: el estudiante no aprobo uno o mas prerrequisitos.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar usuario unico al asignar profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_UsuarioNoDuplicadoEnEstudiante
ON Profesor AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Estudiante e ON e.id_usuario = i.id_usuario
        WHERE i.id_usuario IS NOT NULL
    )
    BEGIN
        RAISERROR(N'El id_usuario no puede estar asignado a un profesor y a un estudiante.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar usuario unico al asignar estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_UsuarioNoDuplicadoEnProfesor
ON Estudiante AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Profesor p ON p.id_usuario = i.id_usuario
        WHERE i.id_usuario IS NOT NULL
    )
    BEGIN
        RAISERROR(N'El id_usuario no puede estar asignado a un estudiante y a un profesor.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar sede de la asignatura en matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_VerificaSede
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        JOIN Asignatura a ON a.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN Aula au ON a.id_aula = au.id_aula
        WHERE m.id_sede <> au.id_sede
    )
    BEGIN
        RAISERROR(N'No se puede matricular: la asignatura no pertenece a la sede de la matricula.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar aula ocupada por dia y bloque
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_HorarioAsignatura_UnaAsignaturaPorAulaBloque
ON HorarioAsignatura AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Asignatura a1 ON a1.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN Horario h1 ON h1.id_horario = i.id_horario
        JOIN HorarioAsignatura ha ON ha.id_horario_asignatura <> i.id_horario_asignatura
        JOIN Horario h2 ON h2.id_horario = ha.id_horario
        JOIN Asignatura a2 ON a2.codigo_interno_asignatura = ha.codigo_interno_asignatura
        WHERE a1.id_aula = a2.id_aula
          AND h1.dia_semana = h2.dia_semana
          AND h1.num_bloque = h2.num_bloque
          AND a1.id_periodo = a2.id_periodo
    )
    BEGIN
        RAISERROR(N'El aula ya esta ocupada en ese dia y bloque para el mismo periodo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar horario del profesor por bloque
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_HorarioAsignatura_UnProfesorPorBloque
ON HorarioAsignatura AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Asignatura a1 ON a1.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN ProfesorAsignatura pa1 ON pa1.codigo_interno_asignatura = a1.codigo_interno_asignatura
        JOIN Horario h1 ON h1.id_horario = i.id_horario
        JOIN HorarioAsignatura ha ON ha.id_horario_asignatura <> i.id_horario_asignatura
        JOIN Horario h2 ON h2.id_horario = ha.id_horario
        JOIN Asignatura a2 ON a2.codigo_interno_asignatura = ha.codigo_interno_asignatura
        JOIN ProfesorAsignatura pa2 ON pa2.codigo_interno_asignatura = a2.codigo_interno_asignatura
        WHERE pa1.codigo_interno_profesor = pa2.codigo_interno_profesor
          AND h1.dia_semana = h2.dia_semana
          AND h1.num_bloque = h2.num_bloque
          AND a1.id_periodo = a2.id_periodo
    )
    BEGIN
        RAISERROR(N'El profesor ya tiene otra clase asignada en ese dia y bloque para el mismo periodo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Impedir eliminar profesor con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_NoEliminarConDependencias
ON Profesor INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_profesor') = 1
    BEGIN
        DELETE p FROM Profesor p INNER JOIN deleted d ON d.codigo_interno_profesor = p.codigo_interno_profesor;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN ProfesorAsignatura pa ON pa.codigo_interno_profesor = d.codigo_interno_profesor
    )
    BEGIN
        RAISERROR(N'No se puede eliminar el profesor porque tiene asignaturas asignadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Tutoria t ON t.codigo_interno_profesor = d.codigo_interno_profesor
    )
    BEGIN
        RAISERROR(N'No se puede eliminar el profesor porque tiene tutorias asociadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_profesor', @value = 1;
    DELETE FROM Profesor WHERE codigo_interno_profesor IN (SELECT codigo_interno_profesor FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_profesor', @value = NULL;
END
GO

--Impedir eliminar curso con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Curso_NoEliminarConDependencias
ON Curso INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_curso') = 1
    BEGIN
        DELETE c FROM Curso c INNER JOIN deleted d ON d.id_curso = c.id_curso;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN AsignaturaCurso ac ON ac.id_curso = d.id_curso
    )
    BEGIN
        RAISERROR(N'No se puede eliminar el curso porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Tutoria t ON t.id_curso = d.id_curso
    )
    BEGIN
        RAISERROR(N'No se puede eliminar el curso porque tiene una tutoria asociada.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_curso', @value = 1;
    DELETE FROM Curso WHERE id_curso IN (SELECT id_curso FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_curso', @value = NULL;
END
GO

--Validar una matricula activa por estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Matricula_UnaActivaPorEstudiante
ON Matricula AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Matricula m ON m.id_estudiante = i.id_estudiante
        WHERE i.estado_matricula = N'Activa'
          AND m.estado_matricula = N'Activa'
          AND m.id_matricula <> i.id_matricula
    )
    BEGIN
        RAISERROR(N'El estudiante ya tiene otra matricula activa.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar matricula activa al inscribir
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_MatriculaValida
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        WHERE m.estado_matricula <> N'Activa'
    )
    BEGIN
        RAISERROR(N'Solo se pueden inscribir asignaturas en matriculas activas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar periodo y annio de matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_PeriodoAcordeAnnio
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Asignatura a ON a.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN Periodo pe ON pe.id_periodo = a.id_periodo
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        WHERE pe.annio <> YEAR(m.fecha_matricula)
    )
    BEGIN
        RAISERROR(N'El periodo de la asignatura no coincide con el annio de la matricula.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar ciclo coherente en matricula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_CursoCoherente
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM AsignaturaCurso
            WHERE codigo_interno_asignatura = i.codigo_interno_asignatura
        )
    )
    BEGIN
        RAISERROR(N'La asignatura no esta asociada a ningun curso.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE EXISTS (
            SELECT 1
            FROM AsignaturaMatricula am
            WHERE am.id_matricula = i.id_matricula
              AND am.codigo_interno_asignatura <> i.codigo_interno_asignatura
        )
        AND NOT EXISTS (
            SELECT c1.codigo_interno_ciclo
            FROM AsignaturaCurso ac1
            JOIN Curso c1 ON c1.id_curso = ac1.id_curso
            WHERE ac1.codigo_interno_asignatura = i.codigo_interno_asignatura
            INTERSECT
            SELECT c2.codigo_interno_ciclo
            FROM AsignaturaMatricula am
            JOIN AsignaturaCurso ac2 ON ac2.codigo_interno_asignatura = am.codigo_interno_asignatura
            JOIN Curso c2 ON c2.id_curso = ac2.id_curso
            WHERE am.id_matricula = i.id_matricula
              AND am.codigo_interno_asignatura <> i.codigo_interno_asignatura
        )
    )
    BEGIN
        RAISERROR(N'La asignatura no pertenece al mismo ciclo que las demas de la matricula.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

--Validar fechas de imparticion del profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_ProfesorImparticionActiva
ON AsignaturaMatricula AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Asignatura a ON a.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN ProfesorAsignatura pa ON pa.codigo_interno_asignatura = a.codigo_interno_asignatura
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        WHERE pa.fecha_fin_imparticion_profe IS NOT NULL
          AND YEAR(pa.fecha_fin_imparticion_profe) < YEAR(m.fecha_matricula)
    )
    BEGIN
        RAISERROR(N'La fecha fin de imparticion del profesor es anterior al annio de la matricula.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar capacidad del aula
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_AsignaturaMatricula_VerificaCapacidad
ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Asignatura a ON a.codigo_interno_asignatura = i.codigo_interno_asignatura
        JOIN Aula au ON au.id_aula = a.id_aula
        CROSS APPLY (
            SELECT COUNT(*) AS total_matriculados
            FROM AsignaturaMatricula am
            JOIN Matricula m ON m.id_matricula = am.id_matricula
            WHERE am.codigo_interno_asignatura = i.codigo_interno_asignatura
              AND m.estado_matricula = N'Activa'
        ) cnt
        WHERE cnt.total_matriculados > au.capacidad
    )
    BEGIN
        RAISERROR(N'La asignatura supera la capacidad maxima del aula.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar matricula antes de registrar nota
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_NotaFinal_EstudianteMatriculado
ON NotaFinal AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1
            FROM AsignaturaMatricula am
            JOIN Matricula m ON m.id_matricula = am.id_matricula
            WHERE m.id_estudiante = i.id_estudiante
              AND am.codigo_interno_asignatura = i.codigo_interno_asignatura
              AND m.estado_matricula IN (N'Activa', N'Finalizada')
        )
    )
    BEGIN
        RAISERROR(N'El estudiante debe estar matriculado en la asignatura antes de registrar la nota.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar codigo oficial del prerrequisito
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Prerrequisito_CodigoOficialExiste
ON Prerrequisito AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.codigo_oficial_asignatura_prerequerida IS NOT NULL
          AND NOT EXISTS (
            SELECT 1 FROM Asignatura a
            WHERE a.codigo_oficial = i.codigo_oficial_asignatura_prerequerida
        )
    )
    BEGIN
        RAISERROR(N'El codigo oficial del prerrequisito no existe en el catalogo de asignaturas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar usuario unico por profesor
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_UsuarioUnico
ON Profesor AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT i.id_usuario
        FROM inserted i
        WHERE i.id_usuario IS NOT NULL
        GROUP BY i.id_usuario
        HAVING COUNT(*) > 1
           OR EXISTS (
               SELECT 1 FROM Profesor p
               WHERE p.id_usuario = i.id_usuario
                 AND p.codigo_interno_profesor NOT IN (SELECT codigo_interno_profesor FROM inserted)
           )
    )
    BEGIN
        RAISERROR(N'El id_usuario ya esta vinculado a otro profesor.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar usuario unico por estudiante
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_UsuarioUnico
ON Estudiante AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT i.id_usuario
        FROM inserted i
        WHERE i.id_usuario IS NOT NULL
        GROUP BY i.id_usuario
        HAVING COUNT(*) > 1
           OR EXISTS (
               SELECT 1 FROM Estudiante e
               WHERE e.id_usuario = i.id_usuario
                 AND e.id_estudiante NOT IN (SELECT id_estudiante FROM inserted)
           )
    )
    BEGIN
        RAISERROR(N'El id_usuario ya esta vinculado a otro estudiante.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar rol Profesor del usuario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Profesor_ValidarRolUsuario
ON Profesor AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Usuario u ON u.id_usuario = i.id_usuario
        WHERE i.id_usuario IS NOT NULL AND u.rol <> N'Profesor'
    )
    BEGIN
        RAISERROR(N'El usuario vinculado al profesor debe tener rol Profesor.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar rol Estudiante del usuario
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_ValidarRolUsuario
ON Estudiante AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Usuario u ON u.id_usuario = i.id_usuario
        WHERE i.id_usuario IS NOT NULL AND u.rol <> N'Estudiante'
    )
    BEGIN
        RAISERROR(N'El usuario vinculado al estudiante debe tener rol Estudiante.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Validar promedio y estado de nota final
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_NotaFinal_CheckPromedio
ON NotaFinal AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (i.estado_nota = N'En curso' AND i.promedio_final IS NOT NULL)
           OR (i.estado_nota IN (N'Aprobado', N'Reprobado') AND i.promedio_final IS NULL)
           OR (i.estado_nota = N'Aprobado' AND i.promedio_final < 70)
           OR (i.estado_nota = N'Reprobado' AND i.promedio_final >= 70)
    )
    BEGIN
        RAISERROR(N'Nota invalida: En curso sin promedio; Aprobado >= 70; Reprobado < 70.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

--Impedir eliminar profesor de asignatura
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_ProfesorAsignatura_NoEliminarProfesor
ON ProfesorAsignatura INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Asignatura a ON a.codigo_interno_asignatura = d.codigo_interno_asignatura
    )
    BEGIN
        RAISERROR(N'No se puede eliminar el profesor asignado: toda asignatura debe tener un profesor.', 16, 1);
        RETURN;
    END
    DELETE FROM ProfesorAsignatura
    WHERE id_profesor_asignatura IN (SELECT id_profesor_asignatura FROM deleted);
END
GO

--Actualizar antiguedad del profesor por fechas
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_ProfesorAsignatura_ActualizarAntiguedad
ON ProfesorAsignatura
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    IF NOT EXISTS (SELECT 1 FROM inserted)
        RETURN;

    IF UPDATE(fecha_inicio_imparticion_profe) OR UPDATE(fecha_fin_imparticion_profe) OR NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        DECLARE @ProfesorOficial TABLE
        (
            codigo_interno_profesor INT NOT NULL,
            codigo_oficial          VARCHAR(20) NOT NULL
        );

        INSERT INTO @ProfesorOficial (codigo_interno_profesor, codigo_oficial)
        SELECT DISTINCT pa.codigo_interno_profesor, a.codigo_oficial
        FROM inserted i
        INNER JOIN ProfesorAsignatura pa ON pa.id_profesor_asignatura = i.id_profesor_asignatura
        INNER JOIN Asignatura a ON a.codigo_interno_asignatura = pa.codigo_interno_asignatura;

        DECLARE @codigo_interno_profesor INT;
        DECLARE @codigo_oficial VARCHAR(20);
        DECLARE cur_antiguedad CURSOR LOCAL FAST_FORWARD FOR
            SELECT codigo_interno_profesor, codigo_oficial FROM @ProfesorOficial;

        OPEN cur_antiguedad;
        FETCH NEXT FROM cur_antiguedad INTO @codigo_interno_profesor, @codigo_oficial;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC sp_ProfesorAsignatura_ActualizarAntiguedad
                @codigo_interno_profesor = @codigo_interno_profesor,
                @codigo_oficial = @codigo_oficial;

            FETCH NEXT FROM cur_antiguedad INTO @codigo_interno_profesor, @codigo_oficial;
        END

        CLOSE cur_antiguedad;
        DEALLOCATE cur_antiguedad;
    END
END
GO

--Actualizar antiguedad del tutor por fechas
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Tutoria_ActualizarAntiguedad
ON Tutoria
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    IF NOT EXISTS (SELECT 1 FROM inserted)
        RETURN;

    IF UPDATE(fecha_inicio_tutoria) OR UPDATE(fecha_fin_tutoria) OR NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        DECLARE @id_tutoria INT;

        DECLARE cur_tutoria CURSOR LOCAL FAST_FORWARD FOR
            SELECT id_tutoria FROM inserted;

        OPEN cur_tutoria;
        FETCH NEXT FROM cur_tutoria INTO @id_tutoria;

        WHILE @@FETCH_STATUS = 0
        BEGIN
           EXEC sp_Tutoria_ActualizarAntiguedad @id_tutoria = @id_tutoria;
            FETCH NEXT FROM cur_tutoria INTO @id_tutoria;
        END

        CLOSE cur_tutoria;
        DEALLOCATE cur_tutoria;
    END
END
GO

-- ============================================================================
-- IMPEDIR ELIMINAR REGISTROS CON DEPENDENCIAS (INTEGRIDAD REFERENCIAL)
-- ============================================================================

--Impedir eliminar sede con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Sede_NoEliminarConDependencias
ON Sede INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_sede') = 1
    BEGIN
        DELETE s FROM Sede s INNER JOIN deleted d ON d.id_sede = s.id_sede;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Aula a ON a.id_sede = d.id_sede)
    BEGIN
        RAISERROR(N'No se puede eliminar la sede porque tiene aulas asociadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM deleted d JOIN Matricula m ON m.id_sede = d.id_sede)
    BEGIN
        RAISERROR(N'No se puede eliminar la sede porque tiene matriculas asociadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_sede', @value = 1;
    DELETE FROM Sede WHERE id_sede IN (SELECT id_sede FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_sede', @value = NULL;
END
GO

--Impedir eliminar aula con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Aula_NoEliminarConDependencias
ON Aula INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_aula') = 1
    BEGIN
        DELETE a FROM Aula a INNER JOIN deleted d ON d.id_aula = a.id_aula;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Asignatura a ON a.id_aula = d.id_aula)
    BEGIN
        RAISERROR(N'No se puede eliminar el aula porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_aula', @value = 1;
    DELETE FROM Aula WHERE id_aula IN (SELECT id_aula FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_aula', @value = NULL;
END
GO

--Impedir eliminar ciclo con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Ciclo_NoEliminarConDependencias
ON Ciclo INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_ciclo') = 1
    BEGIN
        DELETE c FROM Ciclo c INNER JOIN deleted d ON d.codigo_interno_ciclo = c.codigo_interno_ciclo;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Curso c ON c.codigo_interno_ciclo = d.codigo_interno_ciclo)
    BEGIN
        RAISERROR(N'No se puede eliminar el ciclo porque tiene cursos asociados.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaCiclo ac ON ac.codigo_interno_ciclo = d.codigo_interno_ciclo)
    BEGIN
        RAISERROR(N'No se puede eliminar el ciclo porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_ciclo', @value = 1;
    DELETE FROM Ciclo WHERE codigo_interno_ciclo IN (SELECT codigo_interno_ciclo FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_ciclo', @value = NULL;
END
GO

--Impedir eliminar periodo con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Periodo_NoEliminarConDependencias
ON Periodo INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_periodo') = 1
    BEGIN
        DELETE p FROM Periodo p INNER JOIN deleted d ON d.id_periodo = p.id_periodo;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Asignatura a ON a.id_periodo = d.id_periodo)
    BEGIN
        RAISERROR(N'No se puede eliminar el periodo porque tiene asignaturas asociadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_periodo', @value = 1;
    DELETE FROM Periodo WHERE id_periodo IN (SELECT id_periodo FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_periodo', @value = NULL;
END
GO

--Impedir eliminar asignatura con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Asignatura_NoEliminarConDependencias
ON Asignatura INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_asignatura') = 1
    BEGIN
        DELETE a
        FROM Asignatura a
        INNER JOIN deleted d ON d.codigo_interno_asignatura = a.codigo_interno_asignatura;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN HorarioAsignatura ha ON ha.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaMatricula am ON am.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN NotaFinal nf ON nf.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN Asistencia asi ON asi.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaCiclo ac ON ac.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaCurso acu ON acu.codigo_interno_asignatura = d.codigo_interno_asignatura)
       OR EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaPrerrequisito ap ON ap.codigo_interno_asignatura = d.codigo_interno_asignatura)
    BEGIN
        RAISERROR(N'No se puede eliminar la asignatura porque tiene registros dependientes.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_asignatura', @value = 1;
    DISABLE TRIGGER tr_ProfesorAsignatura_NoEliminarProfesor ON ProfesorAsignatura;
    DELETE FROM ProfesorAsignatura
    WHERE codigo_interno_asignatura IN (SELECT codigo_interno_asignatura FROM deleted);
    ENABLE TRIGGER tr_ProfesorAsignatura_NoEliminarProfesor ON ProfesorAsignatura;
    DELETE FROM Asignatura
    WHERE codigo_interno_asignatura IN (SELECT codigo_interno_asignatura FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_asignatura', @value = NULL;
END
GO

--Impedir eliminar estudiante con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Estudiante_NoEliminarConDependencias
ON Estudiante INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_estudiante') = 1
    BEGIN
        DELETE e FROM Estudiante e INNER JOIN deleted d ON d.id_estudiante = e.id_estudiante;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Matricula m ON m.id_estudiante = d.id_estudiante)
    BEGIN
        RAISERROR(N'No se puede eliminar el estudiante porque tiene matriculas asociadas.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM deleted d JOIN NotaFinal nf ON nf.id_estudiante = d.id_estudiante)
       OR EXISTS (SELECT 1 FROM deleted d JOIN Asistencia a ON a.id_estudiante = d.id_estudiante)
    BEGIN
        RAISERROR(N'No se puede eliminar el estudiante porque tiene notas o asistencias registradas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_estudiante', @value = 1;
    DELETE FROM Estudiante WHERE id_estudiante IN (SELECT id_estudiante FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_estudiante', @value = NULL;
END
GO

--Impedir eliminar bloque horario (solo se permite actualizar)
USE InstitutoTECNIC;
GO
IF OBJECT_ID('tr_BloqueHorario_NoEliminarConDependencias', 'TR') IS NOT NULL
    DROP TRIGGER tr_BloqueHorario_NoEliminarConDependencias;
GO
CREATE TRIGGER tr_BloqueHorario_NoEliminar
ON BloqueHorario INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;
    RAISERROR(N'Error: El bloque horario no se puede eliminar, solo actualizar.', 16, 1);
END
GO

--Impedir eliminar horario con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Horario_NoEliminarConDependencias
ON Horario INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_horario') = 1
    BEGIN
        DELETE h FROM Horario h INNER JOIN deleted d ON d.id_horario = h.id_horario;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN HorarioAsignatura ha ON ha.id_horario = d.id_horario)
    BEGIN
        RAISERROR(N'No se puede eliminar el horario porque tiene asignaturas asignadas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_horario', @value = 1;
    DELETE FROM Horario WHERE id_horario IN (SELECT id_horario FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_horario', @value = NULL;
END
GO

--Impedir eliminar prerrequisito con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Prerrequisito_NoEliminarConDependencias
ON Prerrequisito INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_prerrequisito') = 1
    BEGIN
        DELETE p FROM Prerrequisito p INNER JOIN deleted d ON d.id_prerrequisito = p.id_prerrequisito;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaPrerrequisito ap ON ap.id_prerrequisito = d.id_prerrequisito)
    BEGIN
        RAISERROR(N'No se puede eliminar el prerrequisito porque esta asignado a asignaturas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_prerrequisito', @value = 1;
    DELETE FROM Prerrequisito WHERE id_prerrequisito IN (SELECT id_prerrequisito FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_prerrequisito', @value = NULL;
END
GO

--Impedir eliminar matricula con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Matricula_NoEliminarConDependencias
ON Matricula INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_matricula') = 1
    BEGIN
        DELETE m FROM Matricula m INNER JOIN deleted d ON d.id_matricula = m.id_matricula;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN AsignaturaMatricula am ON am.id_matricula = d.id_matricula)
    BEGIN
        RAISERROR(N'No se puede eliminar la matricula porque tiene asignaturas inscritas.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_matricula', @value = 1;
    DELETE FROM Matricula WHERE id_matricula IN (SELECT id_matricula FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_matricula', @value = NULL;
END
GO

--Impedir eliminar usuario con dependencias
USE InstitutoTECNIC;
GO
CREATE TRIGGER tr_Usuario_NoEliminarConDependencias
ON Usuario INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;

    IF SESSION_CONTEXT(N'eliminando_usuario') = 1
    BEGIN
        DELETE u FROM Usuario u INNER JOIN deleted d ON d.id_usuario = u.id_usuario;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM deleted d JOIN Profesor p ON p.id_usuario = d.id_usuario)
       OR EXISTS (SELECT 1 FROM deleted d JOIN Estudiante e ON e.id_usuario = d.id_usuario)
    BEGIN
        RAISERROR(N'No se puede eliminar el usuario porque esta vinculado a un profesor o estudiante.', 16, 1);
        RETURN;
    END
    IF EXISTS (SELECT 1 FROM deleted d JOIN Bitacora b ON b.id_usuario = d.id_usuario)
    BEGIN
        RAISERROR(N'No se puede eliminar el usuario porque tiene registros en bitacora.', 16, 1);
        RETURN;
    END

    EXEC sp_set_session_context @key = N'eliminando_usuario', @value = 1;
    DELETE FROM Usuario WHERE id_usuario IN (SELECT id_usuario FROM deleted);
    EXEC sp_set_session_context @key = N'eliminando_usuario', @value = NULL;
END
GO
