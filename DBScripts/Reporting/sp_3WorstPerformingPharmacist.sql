--top 3 worst performing pharmacists. 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_3WorstPerformingPharmacist')
  DROP PROCEDURE [sp_3WorstPerformingPharmacist]
  GO


CREATE   PROCEDURE [dbo].[sp_3WorstPerformingPharmacist]
	@PharmacyId INT

 AS

BEGIN

SELECT TOP 3 ph.Name, p.FirstName , SUM(ps.UnitCount) AS UnitCount, SUM(ps.UnitCount*ps.UnitPrice) AS TotalPrice
FROM [dbo].[PharmacySales] ps
JOIN Pharmacy_Pharmacist pp ON pp.Pharmacy_PharmacistId = ps.Pharmacy_PharmacistId 
			AND pp.EndDate IS NULL
JOIN Pharmacist p ON p.PharmacistId = pp.PharmacistId
JOIN Pharmacy ph ON ph.PharmacyId = pp.PharmacyId AND ph.PharmacyId = @PharmacyId
Group By ph.Name, p.FirstName
ORDER BY ph.Name, UnitCount ASC

END
GO