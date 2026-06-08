/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 3/7
   TRIGGERS, BITACORA Y USUARIO 
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

-- TRIGGER AUDITORIA: ProfesorAsignatura (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_ProfesorAsignatura_Insert ON ProfesorAsignatura AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en ProfesorAsignatura: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: ProfesorAsignatura (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_ProfesorAsignatura_Update ON ProfesorAsignatura AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en ProfesorAsignatura: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: ProfesorAsignatura (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_ProfesorAsignatura_Delete ON ProfesorAsignatura AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en ProfesorAsignatura: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Tutoria (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Tutoria_Insert ON Tutoria AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Tutoria: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Tutoria (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Tutoria_Update ON Tutoria AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Tutoria: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Tutoria (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Tutoria_Delete ON Tutoria AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Tutoria: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Horario (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Horario_Insert ON Horario AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Horario: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Horario (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Horario_Update ON Horario AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Horario: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Horario (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Horario_Delete ON Horario AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Horario: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Prerrequisito (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Prerrequisito_Insert ON Prerrequisito AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en Prerrequisito: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Prerrequisito (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Prerrequisito_Update ON Prerrequisito AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Prerrequisito: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Prerrequisito (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Prerrequisito_Delete ON Prerrequisito AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Prerrequisito: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
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

-- TRIGGER AUDITORIA: Matricula (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Matricula_Update ON Matricula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Matricula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Matricula (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Matricula_Delete ON Matricula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Matricula: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: DetalleMatricula (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_DetalleMatricula_Insert ON DetalleMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en DetalleMatricula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: DetalleMatricula (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_DetalleMatricula_Update ON DetalleMatricula AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en DetalleMatricula: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: DetalleMatricula (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_DetalleMatricula_Delete ON DetalleMatricula AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en DetalleMatricula: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
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

-- TRIGGER AUDITORIA: Asistencia (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asistencia_Update ON Asistencia AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en Asistencia: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: Asistencia (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Asistencia_Delete ON Asistencia AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en Asistencia: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: HistorialAcademico (INSERT)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_HistorialAcademico_Insert ON HistorialAcademico AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'INSERT en HistorialAcademico: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: HistorialAcademico (UPDATE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_HistorialAcademico_Update ON HistorialAcademico AFTER UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'UPDATE en HistorialAcademico: ', (SELECT COUNT(*) FROM inserted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- TRIGGER AUDITORIA: HistorialAcademico (DELETE)
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_HistorialAcademico_Delete ON HistorialAcademico AFTER DELETE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u INT = TRY_CAST(SESSION_CONTEXT(N'id_usuario') AS INT);
    IF @u IS NULL SELECT TOP 1 @u = id_usuario FROM Usuario WHERE rol = N'Administrador';
    IF @u IS NOT NULL
        INSERT INTO Bitacora (id_usuario, accion, ip_equipo)
        VALUES (@u, CONCAT(N'DELETE en HistorialAcademico: ', (SELECT COUNT(*) FROM deleted), N' fila(s)'),
                CONVERT(VARCHAR(50), CONNECTIONPROPERTY('client_net_address')));
END
GO

-- REGLAS DE NEGOCIO
USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_DetalleMatricula_VerificaPrerrequisito
ON DetalleMatricula AFTER INSERT AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Matricula m ON m.id_matricula = i.id_matricula
        JOIN Prerrequisito pr ON pr.codigo_interno_asignatura = i.codigo_interno_asignatura 
                              AND pr.estado = N'Activo'
        WHERE NOT EXISTS (
            SELECT 1 FROM HistorialAcademico h
            WHERE h.id_estudiante = m.id_estudiante
              AND h.codigo_interno_asignatura = pr.codigo_interno_asignatura_requerida
              AND h.estado = N'Aprobado'
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
CREATE OR ALTER TRIGGER tr_Horario_NoSolapamiento
ON Horario AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Horario h
        JOIN inserted i ON h.numero_aula = i.numero_aula
                       AND h.dia_semana = i.dia_semana
                       AND h.bloque = i.bloque
                       AND h.anio_academico = i.anio_academico
                       AND h.id_horario <> i.id_horario
    )
    BEGIN
        RAISERROR(N'El aula ya esta ocupada en ese dia, bloque y año.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

USE InstitutoTECNIC;
GO
CREATE OR ALTER TRIGGER tr_Horario_ProfesorNoSolapamiento
ON Horario AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Horario h
        JOIN inserted i ON h.id_profesor_asignatura = i.id_profesor_asignatura
                       AND h.dia_semana = i.dia_semana
                       AND h.bloque = i.bloque
                       AND h.anio_academico = i.anio_academico
                       AND h.id_horario <> i.id_horario
    )
    BEGIN
        RAISERROR(N'El profesor ya tiene otra clase asignada en ese dia, bloque y año.', 16, 1);
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
        JOIN ProfesorAsignatura pa ON pa.codigo_interno_profesor = d.codigo_interno_profesor
        WHERE pa.fecha_fin IS NULL
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
        JOIN Asignatura a ON a.id_curso = d.id_curso
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
CREATE OR ALTER TRIGGER tr_HistorialAcademico_CheckPromedio
ON HistorialAcademico AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE (i.estado = N'En curso' AND i.promedio_final IS NOT NULL)
           OR (i.estado IN (N'Aprobado', N'Reprobado') AND i.promedio_final IS NULL)
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