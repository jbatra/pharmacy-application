-- Most Demanded Drug in Pharmacies

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_MostDemamdedDrug')
  DROP PROCEDURE [sp_MostDemamdedDrug]
  GO


CREATE   PROCEDURE [dbo].[sp_MostDemamdedDrug]
AS

IF OBJECT_ID(N'tempdb..#TEMPP') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP]
END

IF OBJECT_ID(N'tempdb..#TEMPP1') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP1]
END

BEGIN
	SELECT ph.Name AS Pharmacy, d.Name AS Drug, SUM(ps.UnitCount) AS DrugQuantitySold
	INTO #TEMPP
	FROM [dbo].[PharmacySales] ps
	JOIN [dbo].[Pharmacy_Pharmacist] pp ON pp.Pharmacy_PharmacistId = ps.Pharmacy_PharmacistId 
	JOIN [dbo].[Pharmacy] ph ON ph.PharmacyId = pp.PharmacyId
	JOIN [dbo].[Drug] d ON d.DrugId = ps.DrugSoldId
	GROUP BY ph.Name,d.Name
	ORDER BY Pharmacy, DrugQuantitySold DESC, Drug


	SELECT Pharmacy,
		   Drug,
		   DrugQuantitySold,
		   RANK() OVER (PARTITION BY Pharmacy 
			ORDER BY DrugQuantitySold DESC) AS saleRank
		   INTO #TEMPP1
	FROM   #TEMPP

	SELECT Pharmacy,
		   Drug, DrugQuantitySold
	FROM #TEMPP1
	WHERE saleRank = 1
	ORDER BY Pharmacy
END

GO