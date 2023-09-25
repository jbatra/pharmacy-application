--Weekly sales report by PharmacyId

USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_WeeklySales_Pharmacy_Report')
  DROP PROCEDURE [sp_WeeklySales_Pharmacy_Report]
  GO


CREATE   PROCEDURE [dbo].[sp_WeeklySales_Pharmacy_Report]
		@PharmacyId INT = NULL
 AS

 If(@PharmacyId IS NULL)
 BEGIN
	SELECT ps.PharmacyId, p.name AS [Name], year(saledate) AS [Year], datepart(week, saledate) As [Week], Sum([SaleAmount]) AS SaleAmount
		FROM [PharmacySales] ps
		JOIN Pharmacy p ON p.PharmacyId = ps.PharmacyId
		GROUP BY ps.PharmacyId, p.name, year(saledate), datepart(week, saledate)
 END
 ELSE
	BEGIN
		SELECT ps.PharmacyId, p.name, year(saledate) AS [Year], datepart(week, saledate) As [Week], Sum([SaleAmount]) AS SaleAmount
		FROM [PharmacySales] ps
		JOIN Pharmacy p ON p.PharmacyId = ps.PharmacyId and ps.PharmacyId = @PharmacyId
		GROUP BY ps.PharmacyId, p.name, year(saledate), datepart(week, saledate)
	END