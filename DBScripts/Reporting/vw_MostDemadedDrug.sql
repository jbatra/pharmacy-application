USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'vw_MostDemadedDrug')
  DROP VIEW [dbo].[vw_MostDemadedDrug]
  GO


CREATE VIEW [dbo].[vw_MostDemadedDrug]
AS

SELECT TOP 1 d.Name, SUM(ps.UnitCount) AS [UnitSold], SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
FROM [dbo].[PharmacySales] AS ps
JOIN Drug d ON d.DrugId = ps.DrugSoldId
GROUP BY d.Name
ORDER BY [UnitSold] DESC

GO


