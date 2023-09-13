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
           (9,4,250,8.00,'20230809',GETDATE()),
		   (9,2,250,8.00,'20230809',GETDATE()),
		   (9,4,250,8.00,'20230809',GETDATE()),
		   (9,1,250,8.00,'20230809',GETDATE()),
		   (10,1,250,8.00,'20230809',GETDATE()),
		   (10,2,250,8.00,'20230809',GETDATE()),
		   (10,3,250,8.00,'20230809',GETDATE()),
		   (10,4,250,8.00,'20230809',GETDATE()),
		   (10,5,250,8.00,'20230809',GETDATE()),
		   (11,4,250,8.00,'20230809',GETDATE()),
		   (11,5,250,8.00,'20230809',GETDATE()),
		   (12,4,250,8.00,'20230809',GETDATE())
GO


