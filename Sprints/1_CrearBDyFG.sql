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
  FILENAME = 'C:\SQLData\TECNIC_Data.mdf',
  SIZE = 25MB, MAXSIZE = 250MB, FILEGROWTH = 5MB )
LOG ON
( NAME = 'TECNIC_Log',
  FILENAME = 'C:\SQLData\TECNIC_Log.ldf',
  SIZE = 10MB, MAXSIZE = 45MB, FILEGROWTH = 4MB );
GO

--  filegroups y sus archivos 
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Academico;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Academico1', FILENAME = 'C:\SQLData\TECNIC_Academico1.ndf',
  SIZE = 15MB, MAXSIZE = 150MB, FILEGROWTH = 5MB ) TO FILEGROUP FG_Academico;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Operaciones;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Operaciones1', FILENAME = 'C:\SQLData\TECNIC_Operaciones1.ndf',
  SIZE = 15MB, MAXSIZE = 150MB, FILEGROWTH = 5MB ) TO FILEGROUP FG_Operaciones;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Seguridad;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Seguridad1', FILENAME = 'C:\SQLData\TECNIC_Seguridad1.ndf',
  SIZE = 10MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP FG_Seguridad;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILEGROUP FG_Indices;
GO
USE master;
GO
ALTER DATABASE InstitutoTECNIC ADD FILE
( NAME = 'TECNIC_Indices1', FILENAME = 'C:\SQLData\TECNIC_Indices1.ndf',
  SIZE = 10MB, MAXSIZE = 100MB, FILEGROWTH = 2MB ) TO FILEGROUP FG_Indices;
GO
