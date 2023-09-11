--Report 1: Delivery Detail 
--All delivery records - dont show any ID columns - but instead show the Warehouse From name and the Pharmacy To name. 
USE [PharmacyManagementStore]
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'V' AND name = 'vw_Delivery')
  DROP VIEW vw_Delivery
  GO

  CREATE VIEW [dbo].[vw_Delivery]
  AS

	SELECT w.Name AS Warehouse, p.Name AS Pharmacy, rx.Name as Drug, d.UnitCount AS [Unit Count]
	, d.UnitPrice AS [Unit Price], (d.UnitCount*d.UnitPrice) as [Total Price]
	, CONVERT(varchar(10),d.DeliveryDate,101) AS [Delivery Date]
	FROM [dbo].[Delivery] d
	JOIN [dbo].[Warehouse] w on w.WarehouseId = d.WarehouseId
	JOIN [dbo].[Pharmacy] p on p.PharmacyId = d.PharmacyId
	JOIN [dbo].[Drug] rx on rx.DrugId = d.DrugId

	GO