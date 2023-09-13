USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[PharmacySales]
           ([Pharmacy_PharmacistId]
           ,[DrugSoldId]
           ,[UnitCount]
           ,[UnitPrice]
           ,[DateOfSale]
           ,[CreatedDate])
     VALUES
           (5,3,180,12.50,'2023-11-09',GETDATE()),
		   (5,3,180,12.50,'2023-11-09',GETDATE()),
		   (5,4,180,12.50,'2023-11-09',GETDATE()),
		   (6,3,180,12.50,'2023-11-09',GETDATE()),
		   (5,5,180,12.50,'2023-11-09',GETDATE()),
		   (7,3,180,12.50,'2023-11-09',GETDATE()),
		   (7,5,180,12.50,'2023-11-09',GETDATE()),
		   (8,3,180,12.50,'2023-11-09',GETDATE()),
		   (6,5,180,12.50,'2023-11-09',GETDATE()),
		   (8,6,180,12.50,'2023-11-09',GETDATE())

		   
GO


