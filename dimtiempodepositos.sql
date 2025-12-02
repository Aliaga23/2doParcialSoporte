USE BnacoDB2;
GO

WITH FechasRecursivas AS (
    SELECT CAST('2022-01-01' AS DATE) AS Fecha
    UNION ALL
    SELECT DATEADD(DAY, 1, Fecha)
    FROM FechasRecursivas
    WHERE Fecha < '2026-12-31'
)
INSERT INTO DepositosDW.dw.DIM_TIEMPO (Fecha, Año, Mes, Trimestre, Semestre, NombreMes)
SELECT
    Fecha,
    YEAR(Fecha) AS Año,
    MONTH(Fecha) AS Mes,
    DATEPART(QUARTER, Fecha) AS Trimestre,
    CASE 
        WHEN MONTH(Fecha) <= 6 THEN 1 
        ELSE 2 
    END AS Semestre,
    CASE MONTH(Fecha)
        WHEN 1 THEN N'Enero'
        WHEN 2 THEN N'Febrero'
        WHEN 3 THEN N'Marzo'
        WHEN 4 THEN N'Abril'
        WHEN 5 THEN N'Mayo'
        WHEN 6 THEN N'Junio'
        WHEN 7 THEN N'Julio'
        WHEN 8 THEN N'Agosto'
        WHEN 9 THEN N'Septiembre'
        WHEN 10 THEN N'Octubre'
        WHEN 11 THEN N'Noviembre'
        WHEN 12 THEN N'Diciembre'
    END AS NombreMes
FROM FechasRecursivas
OPTION (MAXRECURSION 0);
GO
