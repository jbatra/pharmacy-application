--List of the 3 warehouses - with a column showing total delivery revenue and total unit count for each, and total revenue/units average profit.
--Order by most revenue to least. 

USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_WarehouseProfitReport')
  DROP PROCEDURE [sp_WarehouseProfitReport]
  GO


CREATE   PROCEDURE [dbo].[sp_WarehouseProfitReport]
 AS

BEGIN

SELECT Warehouse, Revenue, DrugQuantitySold, (Revenue/DrugQuantitySold) AS [AverageProfit($)]
FROM (
		SELECT w.Name AS Warehouse, SUM(d.SaleAmount) AS Revenue, SUM(d.UnitCount) AS DrugQuantitySold
		FROM [dbo].[Delivery] d
		JOIN [dbo].[Warehouse] w ON d.WarehouseId = w.WarehouseId
		GROUP BY w.Name
) AS P
GROUP BY Warehouse, Revenue, DrugQuantitySold
ORDER BY Warehouse

END
GO