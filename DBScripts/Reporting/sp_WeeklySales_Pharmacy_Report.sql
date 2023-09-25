--Weekly sales report by PharmacyId

USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_WeeklySales_Pharmacy_Report')
  DROP PROCEDURE [sp_WeeklySales_Pharmacy_Report]
  GO

  IF OBJECT_ID(N'tempdb..#TEMPWEEKLY') IS NOT NULL
	BEGIN
		DROP TABLE [#tm]
	END
	GO

CREATE   PROCEDURE [dbo].[sp_WeeklySales_Pharmacy_Report]
		@PharmacyId INT = NULL
 AS

  BEGIN
	 WITH Weekly_CTE
	 AS (
		SELECT ps.PharmacyId, p.Name AS [Pharmacy], YEAR(saledate) AS [Year], DATEPART(WEEK, SaleDate) As [Week], SUM([SaleAmount]) AS SaleAmount
			FROM [PharmacySales] ps
			JOIN Pharmacy p ON p.PharmacyId = ps.PharmacyId
			GROUP BY ps.PharmacyId, p.Name, YEAR(SaleDate), DATEPART(WEEK, SaleDate)
	 )
	 SELECT * INTO #TEMPWEEKLY FROM Weekly_CTE
	 if @PharmacyId IS NULL
		 BEGIN
			SELECT * FROM #TEMPWEEKLY
		 END
	 ELSE
		 BEGIN
			SELECT * FROM #TEMPWEEKLY WHERE PharmacyId = @PharmacyId
		 END

	END
GO