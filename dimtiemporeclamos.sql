USE ReclamosDW3;
GO
WITH Fechas AS (
    SELECT CAST('2023-01-01' AS DATE) AS Fecha
    UNION ALL
    SELECT DATEADD(DAY, 1, Fecha)
    FROM Fechas
    WHERE Fecha < '2026-12-31'
)
INSERT INTO dw.DIM_TIEMPO (TiempoKey, Fecha, Anio, Trimestre, Mes, NombreMes, NombreDia, Hora)
SELECT 
    CAST(FORMAT(Fecha, 'yyyyMMdd') AS INT) AS TiempoKey,
    Fecha,
    YEAR(Fecha) AS Anio,
    DATEPART(QUARTER, Fecha) AS Trimestre,
    MONTH(Fecha) AS Mes,
    CASE MONTH(Fecha)
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END AS NombreMes,
    CASE DATEPART(WEEKDAY, Fecha)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END AS NombreDia,
    0 AS Hora
FROM Fechas
OPTION (MAXRECURSION 0);

GO

SELECT 
    MIN(Fecha) AS FechaInicio,
    MAX(Fecha) AS FechaFin,
    COUNT(*) AS TotalRegistros
FROM dw.DIM_TIEMPO;

SELECT TOP 10 * FROM dw.DIM_TIEMPO ORDER BY TiempoKey;
