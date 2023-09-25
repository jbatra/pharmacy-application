--top 3 worst performing pharmacists. 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_3WorstPerformingPharmacist')
  DROP PROCEDURE [sp_3WorstPerformingPharmacist]
  GO


CREATE   PROCEDURE [dbo].[sp_3WorstPerformingPharmacist]
	@PharmacyId INT

 AS

BEGIN

SELECT TOP 3 ph.Name AS Pharmacy, CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist , SUM(ps.UnitCount) AS Quantity, SUM(ps.SaleAmount) AS SaleAmount
FROM [dbo].[PharmacySales] ps
JOIN Pharmacist p ON p.PharmacistId = ps.PharmacistId
JOIN Pharmacy ph ON ph.PharmacyId = ps.PharmacyId AND ph.PharmacyId = @PharmacyId
Group By ph.Name, p.FirstName, p.LastName
ORDER BY ph.Name, SaleAmount ASC

END
GO