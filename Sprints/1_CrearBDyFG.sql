/* ============================================================================
   PROYECTO: INSTITUTO TECNICO "TECNIC"   -  ARCHIVO 1/7
   CREACION DE BASE, FILEGROUPS
   ============================================================================ */


--  crear la base (primary + log) 
USE master;
GO
CREATE DATABASE InstitutoTECNIC
ON PRIMARY
( NAME = 'TECNIC_Data',
  FILENAME = 'C:\SQL Data\TECNIC_Data.mdf',
  SIZE = 128MB, MAXSIZE = 1024MB, FILEGROWTH = 64MB )
LOG ON
( NAME = 'TECNIC_Log',
  FILENAME = 'C:\SQL LOG\TECNIC_Log.ldf',
  SIZE = 64MB, MAXSIZE = 1024MB, FILEGROWTH = 64MB );
GO

--  filegroups y sus archivos 
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Academico;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Academico1', FILENAME = 'C:\SQL Data\TECNIC_Academico1.ndf',
  SIZE = 256MB, MAXSIZE = 2048MB, FILEGROWTH = 128MB ) TO FILEGROUP FG_Academico;
GO


USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Operaciones;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Operaciones1', FILENAME = 'C:\SQL Data\TECNIC_Operaciones1.ndf',
  SIZE = 512MB, MAXSIZE = 4096MB, FILEGROWTH = 256MB ) TO FILEGROUP FG_Operaciones;
GO


USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Seguridad;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Seguridad1', FILENAME = 'C:\SQL Data\TECNIC_Seguridad1.ndf',
  SIZE = 128MB, MAXSIZE = 1024MB, FILEGROWTH = 64MB ) TO FILEGROUP FG_Seguridad;
GO


