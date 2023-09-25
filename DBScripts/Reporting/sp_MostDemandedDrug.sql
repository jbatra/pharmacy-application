USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_MostDemandedDrug')
  DROP PROCEDURE [sp_MostDemandedDrug]
  GO


CREATE   PROCEDURE [dbo].[sp_MostDemandedDrug]
		@PharmacyId INT = NULL,
		@RankNumber INT = 1
 AS

IF OBJECT_ID(N'tempdb..#TEMPP') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP]
END

IF OBJECT_ID(N'tempdb..#TEMPP1') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP1]
END

If(@PharmacyId IS NULL)
	BEGIN
		SELECT ph.PharmacyId, ph.Name AS Pharmacy, d.Name AS Drug, SUM(ps.UnitCount) AS QuantitySold,SUM(ps.SaleAmount) AS Sales,
			RANK() OVER (PARTITION BY ph.Name 
					ORDER BY SUM(ps.UnitCount) DESC) AS saleRank
		INTO [#TEMPP]
		FROM [dbo].[PharmacySales] ps
			JOIN [dbo].[Pharmacy] ph ON ph.PharmacyId = ps.PharmacyId
			JOIN [dbo].[Drug] d ON d.DrugId = ps.DrugId
		GROUP BY ph.PharmacyId, ph.Name,d.Name
		ORDER BY Pharmacy, QuantitySold DESC, Drug

		SELECT PharmacyId, Pharmacy,
				Drug, QuantitySold, Sales
		FROM [#TEMPP]
		WHERE saleRank = @RankNumber
		ORDER BY Pharmacy
	END
ELSE
	BEGIN
		SELECT ph.PharmacyId, ph.Name AS Pharmacy, d.Name AS Drug, SUM(ps.UnitCount) AS QuantitySold, SUM(ps.SaleAmount) AS Sales,
			RANK() OVER (PARTITION BY ph.Name 
					ORDER BY SUM(ps.UnitCount) DESC) AS saleRank
		INTO [#TEMPP1]
		FROM [dbo].[PharmacySales] ps
		JOIN [dbo].[Pharmacy] ph ON ph.PharmacyId = ps.PharmacyId AND ps.PharmacyId = @PharmacyId
		JOIN [dbo].[Drug] d ON d.DrugId = ps.DrugId
		GROUP BY ph.PharmacyId, ph.Name,d.Name
		ORDER BY Pharmacy, QuantitySold DESC, Drug

		SELECT PharmacyId, Pharmacy,
				Drug, QuantitySold, Sales
		FROM [#TEMPP1]
		WHERE saleRank = @RankNumber
		ORDER BY Pharmacy
	END

IF OBJECT_ID(N'tempdb..#TEMPP') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP]
END

IF OBJECT_ID(N'tempdb..#TEMPP1') IS NOT NULL
BEGIN
	DROP TABLE [#TEMPP1]
END

GO
