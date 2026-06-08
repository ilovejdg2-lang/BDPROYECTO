/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 3/7
   TRIGGERS, BITACORA Y REGLAS DE NEGOCIO
   ============================================================================ */

-- TRIGGER AUDITORIA: Sede (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Sede_Insert ON Sede AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Sede: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Sede (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Sede_Update ON Sede AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Sede: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Sede (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Sede_Delete ON Sede AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Sede: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Aula (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Aula_Insert ON Aula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Aula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Aula (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Aula_Update ON Aula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Aula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Aula (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Aula_Delete ON Aula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Aula: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Ciclo (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Ciclo_Insert ON Ciclo AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Ciclo: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Ciclo (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Ciclo_Update ON Ciclo AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Ciclo: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Ciclo (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Ciclo_Delete ON Ciclo AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Ciclo: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Curso (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Curso_Insert ON Curso AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Curso: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Curso (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Curso_Update ON Curso AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Curso: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Curso (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Curso_Delete ON Curso AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Curso: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Profesor (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Profesor_Insert ON Profesor AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Profesor: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Profesor (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Profesor_Update ON Profesor AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Profesor: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Profesor (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Profesor_Delete ON Profesor AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Profesor: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Asignatura (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asignatura_Insert ON Asignatura AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Asignatura: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Asignatura (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asignatura_Update ON Asignatura AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Asignatura: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Asignatura (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asignatura_Delete ON Asignatura AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Asignatura: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Estudiante (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Estudiante_Insert ON Estudiante AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Estudiante: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Estudiante (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Estudiante_Update ON Estudiante AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Estudiante: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Estudiante (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Estudiante_Delete ON Estudiante AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Estudiante: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Matricula (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Matricula_Insert ON Matricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Matricula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: AsignaturaMatricula (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_AsignaturaMatricula_Insert ON AsignaturaMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en AsignaturaMatricula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: NotaFinal (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_NotaFinal_Insert ON NotaFinal AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en NotaFinal: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: NotaFinal (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_NotaFinal_Update ON NotaFinal AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en NotaFinal: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Asistencia (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asistencia_Insert ON Asistencia AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Asistencia: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- REGLAS DE NEGOCIO
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_AsignaturaMatricula_VerificaPrerrequisito
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

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_HorarioAsignatura_NoSolapamientoAula
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
    )
    BEGIN
        RAISERROR(N'El aula ya esta ocupada en ese dia y bloque.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_HorarioAsignatura_NoSolapamientoProfesor
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
        WHERE a1.codigo_interno_profesor = a2.codigo_interno_profesor
          AND h1.dia_semana = h2.dia_semana
          AND h1.num_bloque = h2.num_bloque
    )
    BEGIN
        RAISERROR(N'El profesor ya tiene otra clase asignada en ese dia y bloque.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Profesor_NoDeleteIfHasActiveAssignments
ON Profesor INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Asignatura a ON a.codigo_interno_profesor = d.codigo_interno_profesor
        WHERE a.fecha_fin_imparticion_profe IS NULL
    )
    BEGIN
        RAISERROR(N'No se puede eliminar un profesor que tiene asignaturas activas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Profesor WHERE codigo_interno_profesor IN (SELECT codigo_interno_profesor FROM deleted);
    END
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Curso_NoDeleteIfHasAsignaturas
ON Curso INSTEAD OF DELETE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN AsignaturaCurso ac ON ac.id_curso = d.id_curso
    )
    BEGIN
        RAISERROR(N'No se puede eliminar un curso que tiene asignaturas asociadas.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Curso WHERE id_curso IN (SELECT id_curso FROM deleted);
    END
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_NotaFinal_CheckPromedio
ON NotaFinal AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (i.estado_nota = N'En curso' AND i.promedio_final IS NOT NULL)
           OR (i.estado_nota IN (N'Aprobado', N'Reprobado') AND i.promedio_final IS NULL)
    )
    BEGIN
        RAISERROR(N'En curso debe tener promedio NULL, Aprobado/Reprobado deben tener promedio NOT NULL.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

USE InstitutoTECNIC;
GO
SELECT COUNT(*) AS total_triggers FROM sys.triggers WHERE is_ms_shipped = 0;
GO
