--List all Pharmacists each with Pharmacy Name they work at, 
--name of their primary drug, 
--total unit count that their pharmacy sold of their primary drug, 
--and total sold not of their primary drug

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_PharmacistMTDReport')
  DROP PROCEDURE [sp_PharmacistMTDReport]
  GO


CREATE   PROCEDURE [dbo].[sp_PharmacistMTDReport]
	@PharmacyId INT = NULL,
	@Month    INT = NULL,
    @Year     INT = NULL

 AS
  
IF OBJECT_ID(N'tempdb..#TempTblPrimaryRx') IS NOT NULL
BEGIN
DROP TABLE [#TempTblPrimaryRx]
END

IF OBJECT_ID(N'tempdb..#TempTblNoPrimaryRx') IS NOT NULL
BEGIN
DROP TABLE [#TempTblNoPrimaryRx]
END
IF OBJECT_ID(N'tempdb..#TempTblPrimaryRx1') IS NOT NULL
BEGIN
DROP TABLE [#TempTblPrimaryRx1]
END

IF OBJECT_ID(N'tempdb..#TempTblNoPrimaryRx1') IS NOT NULL
BEGIN
DROP TABLE [#TempTblNoPrimaryRx1]
END

 SET @Month = ISNULL(@Month, MONTH(GETDATE()))
 SET @Year = ISNULL(@Year, YEAR(GETDATE()))

IF @PharmacyId IS NULL
BEGIN

SElECT CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist ,p.PrimaryDrugId, ph.Name AS Pharmacy,d.Name AS [PrimaryDrug],
		SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
		INTO [#TempTblPrimaryRx]
		FROM Pharmacist p
		Join Pharmacy_Pharmacist pp ON p.PharmacistId = pp.PharmacistId AND pp.EndDate IS NULL
		Join Pharmacy ph ON pp.PharmacyId = ph.PharmacyId
		JOIN PharmacySales ps ON ps.Pharmacy_PharmacistId = pp.Pharmacy_PharmacistId AND ps.DrugSoldId = p.PrimaryDrugId 
		AND MONTH(ps.DateOfSale) = @Month AND YEAR(ps.DateOfSale) = @Year
		JOIN Drug d ON d.DrugId = ps.DrugSoldId
		Group BY p.FirstName,p.LastName, p.PrimaryDrugId, ph.Name,d.Name
END
ELSE
BEGIN --
SElECT CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist ,p.PrimaryDrugId, ph.Name AS Pharmacy,d.Name AS [PrimaryDrug],
		SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
		INTO [#TempTblPrimaryRx1]
		FROM Pharmacist p
		Join Pharmacy_Pharmacist pp ON p.PharmacistId = pp.PharmacistId AND pp.EndDate IS NULL AND pp.PharmacyId = @PharmacyId
		Join Pharmacy ph ON pp.PharmacyId = ph.PharmacyId
		JOIN PharmacySales ps ON ps.Pharmacy_PharmacistId = pp.Pharmacy_PharmacistId AND ps.DrugSoldId = p.PrimaryDrugId 
		AND MONTH(ps.DateOfSale) = @Month AND YEAR(ps.DateOfSale) = @Year
		JOIN Drug d ON d.DrugId = ps.DrugSoldId
		Group BY p.FirstName,p.LastName, p.PrimaryDrugId, ph.Name,d.Name
END

IF @PharmacyId IS NULL
BEGIN
		SElECT CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist, ph.Name AS Pharmacy, SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
		INTO [#TempTblNoPrimaryRx]
		FROM Pharmacist p
		Join Pharmacy_Pharmacist pp ON p.PharmacistId = pp.PharmacistId AND pp.EndDate IS NULL 
		Join Pharmacy ph ON pp.PharmacyId = ph.PharmacyId
		JOIN PharmacySales ps ON ps.Pharmacy_PharmacistId = pp.Pharmacy_PharmacistId AND ps.DrugSoldId != p.PrimaryDrugId 
		AND MONTH(ps.DateOfSale) = @Month AND YEAR(ps.DateOfSale) = @Year
		--JOIN Drug d ON d.DrugId = p.PrimaryDrugId
		Group BY p.FirstName, p.LastName, ph.Name
END
ELSE
BEGIN
	SElECT CONCAT(p.FirstName, ' ', p.LastName) AS Pharmacist, ph.Name AS Pharmacy, SUM(ps.UnitCount) AS UnitCount,
		SUM(ps.UnitCount*ps.UnitPrice) AS [TotalPrice]
		INTO [#TempTblNoPrimaryRx1]
		FROM Pharmacist p
		Join Pharmacy_Pharmacist pp ON p.PharmacistId = pp.PharmacistId AND pp.EndDate IS NULL AND pp.PharmacyId = @PharmacyId
		Join Pharmacy ph ON pp.PharmacyId = ph.PharmacyId
		JOIN PharmacySales ps ON ps.Pharmacy_PharmacistId = pp.Pharmacy_PharmacistId AND ps.DrugSoldId != p.PrimaryDrugId 
		AND MONTH(ps.DateOfSale) = @Month AND YEAR(ps.DateOfSale) = @Year
		--JOIN Drug d ON d.DrugId = p.PrimaryDrugId
		Group BY p.FirstName, p.LastName, ph.Name
END
		
--SELECT * FROM [#TempTblPrimaryRx]
--SELECT * FROM [#TempTblNoPrimaryRx]

IF @PharmacyId IS NULL
	BEGIN
		SELECT np.Pharmacist, np.Pharmacy, p.PrimaryDrug, p.UnitCount, p.TotalPrice, np.UnitCount As NPUnitCount, np.TotalPrice AS NPTotalPrice
		from [#TempTblPrimaryRx] p
		RIGHT JOIN [#TempTblNoPrimaryRx] np ON p.Pharmacist = np.Pharmacist AND p.Pharmacy = np.Pharmacy
	END
ELSE
BEGIN
SELECT np.Pharmacist, np.Pharmacy, p.PrimaryDrug, p.UnitCount, p.TotalPrice, np.UnitCount As NPUnitCount, np.TotalPrice AS NPTotalPrice
		from [#TempTblPrimaryRx1] p
		RIGHT JOIN [#TempTblNoPrimaryRx1] np ON p.Pharmacist = np.Pharmacist AND p.Pharmacy = np.Pharmacy
END
GO