USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_MostDemandedDrug')
  DROP PROCEDURE [sp_MostDemandedDrug]
  GO


CREATE   PROCEDURE [dbo].[sp_MostDemandedDrug]
 AS

BEGIN

SELECT TOP 1 d.Name, SUM(ps.UnitCount) AS [UnitSold], SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
FROM [dbo].[PharmacySales] AS ps
JOIN Drug d ON d.DrugId = ps.DrugSoldId
GROUP BY d.Name
ORDER BY [UnitSold] DESC

END
GO
