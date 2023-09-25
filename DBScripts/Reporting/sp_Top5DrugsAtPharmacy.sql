USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_Top5DrugsAtPharmacy')
  DROP PROCEDURE [sp_Top5DrugsAtPharmacy]
  GO

CREATE   PROCEDURE [dbo].[sp_Top5DrugsAtPharmacy]
		@PharmacyId INT
 AS
 
SELECT top 5 ph.PharmacyId, ph.Name AS Pharmacy, d.Name AS Drug, 
			SUM(ps.UnitCount) AS QuantitySold
			
		FROM [dbo].[PharmacySales] ps
			JOIN [dbo].[Pharmacy] ph ON ph.PharmacyId = ps.PharmacyId AND ps.PharmacyId = @PharmacyId
			JOIN [dbo].[Drug] d ON d.DrugId = ps.DrugId
		GROUP BY ph.PharmacyId, ph.Name,d.Name
		ORDER BY Pharmacy, QuantitySold DESC, Drug
GO


