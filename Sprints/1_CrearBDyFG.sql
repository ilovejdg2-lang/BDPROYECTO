/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 1/9
   CREACION DE BASE, FILEGROUPS
   ============================================================================ */


--  crear la base (primary + log)
USE master;
GO
CREATE DATABASE InstitutoTECNIC
ON PRIMARY
( NAME = 'TECNIC_Data',
  FILENAME = 'C:\SQL Data\TECNIC_Data.mdf',
  SIZE = 512MB, MAXSIZE = 7GB, FILEGROWTH = 256MB )
LOG ON
( NAME = 'TECNIC_Log',
  FILENAME = 'C:\SQL LOG\TECNIC_Log.ldf',
  SIZE = 512MB, MAXSIZE = 8GB, FILEGROWTH = 256MB );
GO

--  filegroups y sus archivos
--fg_academico para las tablas de academia como sede, aula, ciclo, curso, etc.
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Academico;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Academico1', FILENAME = 'C:\SQL Data\TECNIC_Academico1.ndf',
  SIZE = 1024MB, MAXSIZE = 8GB, FILEGROWTH = 512MB ) TO FILEGROUP FG_Academico;
GO

--fg_operaciones para las tablas de operaciones como matricula, inscripcion, etc.
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Operaciones;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Operaciones1', FILENAME = 'C:\SQL Data\TECNIC_Operaciones1.ndf',
  SIZE = 1024MB, MAXSIZE = 12GB, FILEGROWTH = 512MB ) TO FILEGROUP FG_Operaciones;
GO

--fg_seguridad para las tablas de seguridad como usuario, bitacora, etc.
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Seguridad;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Seguridad1', FILENAME = 'C:\SQL Data\TECNIC_Seguridad1.ndf',
  SIZE = 256MB, MAXSIZE = 7GB, FILEGROWTH = 128MB ) TO FILEGROUP FG_Seguridad;
GO

