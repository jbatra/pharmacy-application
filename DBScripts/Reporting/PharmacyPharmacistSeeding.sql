USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Pharmacy_Pharmacist]
           ([PharmacistId]
           ,[PharmacyId]
           ,[StartDate]        
           ,[CreatedDate])
     VALUES
           (2,2,'20221109',GETDATE()),
		   (3,2,'20221109',GETDATE()),
		   (4,2,'20221109',GETDATE()),
		   (5,4,'20221109',GETDATE()),
		   (3,4,'20221109',GETDATE()),
		   (1,4,'20221109',GETDATE()),
		   (2,5,'20221109',GETDATE()),
		   (1,5,'20221109',GETDATE())
		   
GO

