USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Drug] ([Name], [Description], [Strength], [CreatedDate])
     VALUES ('Ibuprofen','Pain killer, Fever reducer', '200mg', GETDATE()),
      ('Amoxicillian','Anit-Biotic', '1 Tbsp', GETDATE()),
      ('Prednisone','Steroid', '5mg', GETDATE()),
	  ('Nortriptyline','Anit-Biotic', '25mg', GETDATE()),
	  ('Midodrine','orthostatic hypotension', '5mg', GETDATE()),
	  ('Claritin-D','Seasonal Allergies', '2mg', GETDATE()),
	  ('Desitin', 'cream', '2mg', GETDATE())
GO


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Pharmacist] ([FirstName],[LastName],[Age],[CreatedDate])
     VALUES ('John','Smith',32,GETDATE()),
	 ('Emma','Miller',28,GETDATE()),
	 ('Hanna','Anderson',39,GETDATE()),
	 ('Raymond','Jones',32,GETDATE()),
	 ('Christopher','Barnett',53,GETDATE()),
	 ('Elaine','Aulgar',58,GETDATE()),
	 ('Jimmy','Meyer',45,GETDATE())
GO


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Pharmacy_Pharmacist]
           ([PharmacistId],[PharmacyId],[StartDate],[EndDate],[CreatedDate])
     VALUES
          

		   (1,1,'2022-04-03', '2023-06-17','2023-09-07'),
(1,2,'2022-04-03',	NULL,'2023-09-07'),
(1,3,'2022-04-03',NULL,'2023-09-07'),
(2,1,'2022-04-03',NULL,'2023-09-07'),
(2,4,'2022-04-03',NULL,'2023-09-07'),
(3,5,'2022-04-03',NULL,'2023-09-07'),
(4,4,'2022-04-03',NULL,'2023-09-07'),
(4,5,'2022-04-03',NULL,'2023-09-07')

GO


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Warehouse] ([Name],[Address],[City],[State],[Zip],[CreatedDate])
     VALUES
           ('Warehouses Plus','765 Center St.','Plano','Texas','76537',GetDate()),
           ('Newline Interactive','2930 Telecom Pkwy','Richardson','Texas','75082',GetDate()),
           ('US Storage Centers','6404 Hwy 78','Irving','Texas','76537',GetDate()),
           ('Industrial Warehouse','345 Breckinridge Rd.','Richardson','Texas','75082',GetDate())
GO

USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Warehouse_Drug] ([WarehouseId],[DrugId],[Quantity],[CreatedDate])
     VALUES	
	 (1,1,1000,GetDate()),
	 (2,1,1000,GetDate()),
	 (4,2,1000,GetDate()),
	 (3,3,1000,GetDate()),
	 (4,4,1000,GetDate()),
	 (3,7,1000,GetDate()),
	 (4,6,1000,GetDate()),
	 (3,5,1000,GetDate()),
	 (2,1,1000,GetDate())
GO


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[Delivery] ([WarehouseId],[PharmacyId],[DrugId],[UnitCount],[UnitPrice],[DeliveryDate],[CreatedDate])
     VALUES
           (1,1,1,100,2.50,'2023-08-01',GETDATE()),
		   (1,1,5,100,12.50,'2023-08-01',GETDATE()),
           (1,1,2,100,12.50,'2023-08-10',GETDATE()),
           (2,2,5,100,1.50,'2023-08-09',GETDATE()),
           (3,3,2,100,10.50,'2023-08-03',GETDATE()),
           (3,5,5,100,7.00,'2023-08-10',GETDATE()),
           (3,5,4,100,7.00,'2023-08-10',GETDATE()),
           (1,1,7,100,12.50,'2023-08-01',GETDATE()),
           (4,2,1,100,1.50,'2023-08-01',GETDATE()),
           (4,4,7,100,6.50,'2023-08-15',GETDATE()),
           (4,6,5,100,2.00,'2023-08-15',GETDATE()),
           (4,6,2,100,2.00,'2023-08-22',GETDATE()),
           (4,6,3,100,2.00,'2023-08-22',GETDATE()),
           (1,1,4,100,12.50,'2023-08-15',GETDATE()),
           (2,1,5,100,12.50,'2023-08-09',GETDATE()),
           (2,1,1,100,12.50,'2023-08-05',GETDATE()),
           (2,1,7,100,12.50,'2023-08-16',GETDATE()),
           (2,1,2,100,12.50,'2023-08-02',GETDATE()),
           (3,5,2,100,7.00,'2023-08-17',GETDATE()),
           (3,5,3,100,7.00,'2023-08-17',GETDATE()),
           (1,1,6,100,12.50,'2023-08-08',GETDATE()),
           (1,1,3,100,12.50,'2023-08-08',GETDATE())
GO


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[PharmacySales]
           ([Pharmacy_PharmacistId],[DrugSoldId],[UnitCount],[UnitPrice],[DateOfSale],[CreatedDate])
     VALUES
           
		(2,1,90,12.50,'20230901',GETDATE()),
		(2,3,60,10.50,'20230902',GETDATE()),
		(2,5,120,7.00,'20230903',GETDATE()),
		(3,1,150,12.50,'20230901',GETDATE()),
		(3,3,90,10.50,'20230903',GETDATE()),
		(4,2,30,1.50,'20230901',GETDATE()),
		(4,6,30,2.00,'20230907',GETDATE()),
		(4,5,60,7.00,'20230908',GETDATE()),
		(5,2,90,1.50,'20230901',GETDATE()),
		(5,1,120,12.50,'20230909',GETDATE()),
		(5,5,150,7.00,'20230903',GETDATE()),
		(6,7,180,6.00,'20230901',GETDATE()),
		(6,4,30,6.50,'20230902',GETDATE()),
		(6,3,30,10.50,'20230904',GETDATE()),
		(6,2,60,1.50,'20230905',GETDATE()),
		(7,7,90,6.00,'20230907',GETDATE()),
		(7,3,30,10.50,'20230901',GETDATE()),
		(7,6,15,2.00,'20230902',GETDATE()),
		(7,1,120,12.50,'20230901',GETDATE()),
		(8,7,150,6.00,'20230906',GETDATE()),
		(8,2,30,1.50,'20230907',GETDATE()),
		(8,6,90,2.00,'20230902',GETDATE()),
		(8,3,180,10.50,'20230907',GETDATE()),
		(8,5,30,7.00,'20230908',GETDATE())