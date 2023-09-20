--List all Pharmacists each with Pharmacy Name they work at, 
--name of the drug they sold, 
--total unit count that drug, 
--and total sales amount of the drug

USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_PharmacistDrugMTDReport')
  DROP PROCEDURE [sp_PharmacistDrugMTDReport]
  GO


CREATE   PROCEDURE [dbo].[sp_PharmacistDrugMTDReport]
	@PharmacyId INT = NULL,
	@Month    INT = NULL,
    @Year     INT = NULL

 AS

  SET @Month = ISNULL(@Month, MONTH(GETDATE()))
  SET @Year = ISNULL(@Year, YEAR(GETDATE()))

 IF @PharmacyId IS NULL
	BEGIN
		SElECT ph.Name AS Pharmacy,ph.PharmacyId, CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist, p.PharmacistId , d.Name AS [DrugName],
		SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [SaleAmount]
		FROM Pharmacist p
		JOIN PharmacySales ps ON ps.PharmacistId = p.PharmacistId  
		Join Pharmacy ph ON ph.PharmacyId = ps.PharmacyId
		AND MONTH(ps.SaleDate) = @Month AND YEAR(ps.SaleDate) = @Year
		JOIN Drug d ON d.DrugId = ps.DrugId
		Group BY ph.PharmacyId, ph.Name, p.FirstName,p.LastName, p.PharmacistId , d.Name
		Order BY ph.Name,p.FirstName,p.LastName,d.Name
	END
ELSE
	BEGIN
		SElECT ph.Name AS Pharmacy,ph.PharmacyId, CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist, p.PharmacistId , d.Name AS [DrugName],
		SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [SaleAmount]
		FROM Pharmacist p
		JOIN PharmacySales ps ON ps.PharmacistId = p.PharmacistId  AND ps.PharmacyId = @PharmacyId
		Join Pharmacy ph ON ph.PharmacyId = ps.PharmacyId 
		AND MONTH(ps.SaleDate) = @Month AND YEAR(ps.SaleDate) = @Year
		JOIN Drug d ON d.DrugId = ps.DrugId
		Group BY ph.PharmacyId, ph.Name, p.FirstName,p.LastName, p.PharmacistId , d.Name
		Order BY ph.Name,p.FirstName,p.LastName,d.Name
	END
GO
