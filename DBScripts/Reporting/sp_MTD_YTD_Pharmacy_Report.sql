--MTD And YTD sales repot for pharmacies

USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_MTD_YTD_Pharmacy_Report')
  DROP PROCEDURE [sp_MTD_YTD_Pharmacy_Report]
  GO


CREATE   PROCEDURE [dbo].[sp_MTD_YTD_Pharmacy_Report]
 AS
 
IF OBJECT_ID(N'tempdb..#TEMPP') IS NOT NULL
BEGIN
	DROP TABLE [#tm]
END

IF OBJECT_ID(N'tempdb..#TEMPP1') IS NOT NULL
BEGIN
	DROP TABLE [#tm1]
END

BEGIN
	SELECT ph.Name AS Pharmacy, ph.PharmacyId , DATENAME(MONTH, ps.SaleDate) AS SaleMonth, SUM(ps.SaleAmount) As TotalSalesMTD
	INTO #tm
	FROM [dbo].[PharmacySales] ps
	JOIN Pharmacy ph ON ph.PharmacyId = ps.PharmacyId AND MONTH(ps.SaleDate) = MONTH(GetDate())
	GROUP BY ph.Name, ph.PharmacyId, DATENAME(MONTH, ps.SaleDate)
	ORDER BY Pharmacy,  SUM(ps.SaleAmount) DESC


	SELECT ph.Name AS Pharmacy,ph.PharmacyId, YEAR(ps.SaleDate) AS SaleYear, SUM(ps.SaleAmount) As TotalSalesYTD
	INTO #tm1
	FROM [dbo].[PharmacySales] ps
	JOIN Pharmacy ph ON ph.PharmacyId = ps.PharmacyId AND YEAR(ps.SaleDate) = YEAR(GetDate())
	GROUP BY ph.Name, ph.PharmacyId,YEAR(ps.SaleDate)
	ORDER BY YEAR(ps.SaleDate), Pharmacy,  SUM(ps.SaleAmount) DESC

	SELECT tm.PharmacyId,tm.Pharmacy,tm.SaleMonth,tm.TotalSalesMTD, tm1.SaleYear,tm1.TotalSalesYTD
	FROM #tm tm
	JOIN #tm1 tm1 ON tm.PharmacyId = tm1.PharmacyId
	ORDER BY tm1.TotalSalesYTD DESC
END
GO



