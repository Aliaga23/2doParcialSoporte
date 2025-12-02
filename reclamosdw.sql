
USE master;

CREATE DATABASE ReclamosDW3


USE ReclamosDW3;

CREATE SCHEMA dw AUTHORIZATION dbo;


CREATE TABLE dw.DIM_TIEMPO (
    TiempoKey INT PRIMARY KEY,
    Fecha DATE NOT NULL UNIQUE,
    Anio INT NOT NULL,
    Trimestre INT NOT NULL,
    Mes INT NOT NULL,
    NombreMes NVARCHAR(20) NOT NULL,
	NombreDia NVARCHAR(20) NOT NULL,
    Hora INT NOT NULL

);
GO

CREATE TABLE dw.DIM_SUCURSAL (
    SucursalKey INT IDENTITY(1,1) PRIMARY KEY,
    SucursalId BIGINT NOT NULL UNIQUE,
    Codigo NVARCHAR(50),
    Nombre NVARCHAR(200),
    Ciudad NVARCHAR(100),
    Region NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

CREATE TABLE dw.DIM_CLIENTE (
    ClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId BIGINT NOT NULL UNIQUE,
    NombreCompleto NVARCHAR(200),
    TipoCliente NVARCHAR(20),
    PersonaId BIGINT NULL,
    OrganizacionId BIGINT NULL
);
GO


CREATE TABLE dw.DIM_CATEGORIA (
    CategoriaKey INT IDENTITY(1,1) PRIMARY KEY,
    Categoria NVARCHAR(50) NOT NULL UNIQUE,
    Descripcion NVARCHAR(200)
);


INSERT INTO dw.DIM_CATEGORIA (Categoria, Descripcion)
SELECT DISTINCT 
    r.Categoria, 
    CONCAT('Reclamos de tipo ', r.Categoria) AS Descripcion
FROM BnacoDB2.relaciones.Reclamo r;
GO


CREATE TABLE dw.FACT_RECLAMOS (
    FactId BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,

    ReclamoId BIGINT NOT NULL,

    TiempoKey INT NOT NULL,
    ClienteKey INT NOT NULL,
    SucursalKey INT NOT NULL,
    CategoriaKey INT NOT NULL,

    CantidadReclamos INT NOT NULL DEFAULT 1,
    
    EsAtendido INT NOT NULL DEFAULT 0,
    EsPendiente INT NOT NULL DEFAULT 0,
    
    EsResuelto INT NOT NULL DEFAULT 0,
    EsNoResuelto INT NOT NULL DEFAULT 0,

    DiasResolucion INT NULL,
    HorasResolucion INT NULL
);
GO


