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

	BEGIN
		;With MTD_CTE 
			AS ( 
			SELECT ph.PharmacyId, ph.Name AS Pharmacy, d.Name AS Drug, SUM(ps.UnitCount) AS QuantitySold, SUM(ps.SaleAmount) AS Sales,
						RANK() OVER (PARTITION BY ph.Name 
								ORDER BY SUM(ps.UnitCount) DESC) AS saleRank		
					FROM [dbo].[PharmacySales] ps
						JOIN [dbo].[Pharmacy] ph ON ph.PharmacyId = ps.PharmacyId
						JOIN [dbo].[Drug] d ON d.DrugId = ps.DrugId
					GROUP BY ph.PharmacyId, ph.Name,d.Name
			)
			SELECT PharmacyId, Pharmacy, Drug, QuantitySold, Sales
					INTO [#TEMPP]
					FROM MTD_CTE
					WHERE saleRank = @RankNumber
		

			If(@PharmacyId IS NULL)
				BEGIN
					SELECT * from [#TEMPP] ORDER BY QuantitySold DESC 
				END
			ELSE
				BEGIN
					SELECT * from [#TEMPP] Where PharmacyId = @PharmacyId
				END		

	END

GO
