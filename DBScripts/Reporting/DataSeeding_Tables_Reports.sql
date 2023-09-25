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
           ([PharmacyId],[PharmacistId],[DrugId],[UnitCount],[UnitPrice],[SaleDate],[CreatedDate])
     VALUES
           
		(5,3,1,90,12.50,'20230901',GETDATE()),
		(4,4,3,60,10.50,'20230902',GETDATE()),
		(5,4,5,120,7.00,'20230903',GETDATE()),
		(2,1,1,150,12.50,'20230901',GETDATE()),
		(2,1,3,90,10.50,'20230903',GETDATE()),
		(3,1,2,30,1.50,'20230901',GETDATE()),
		(3,1,6,30,2.00,'20230907',GETDATE()),
		(1,2,5,60,7.00,'20230908',GETDATE()),
		(1,2,2,90,1.50,'20230901',GETDATE()),
		(4,2,1,120,12.50,'20230909',GETDATE()),
		(4,2,5,150,7.00,'20230903',GETDATE()),
		(4,2,7,180,6.00,'20230901',GETDATE()),
		(5,3,4,30,6.50,'20230902',GETDATE()),
		(5,3,3,30,10.50,'20230904',GETDATE()),
		(5,3,2,60,1.50,'20230905',GETDATE()),
		(4,4,7,90,6.00,'20230907',GETDATE()),
		(4,4,3,30,10.50,'20230901',GETDATE()),
		(4,4,6,15,2.00,'20230902',GETDATE()),
		(5,4,1,120,12.50,'20230901',GETDATE()),
		(5,4,7,150,6.00,'20230906',GETDATE()),
		(5,4,2,30,1.50,'20230907',GETDATE()),
		(5,4,6,90,2.00,'20230902',GETDATE()),
		(2,1,3,180,10.50,'20230907',GETDATE()),
		(1,2,5,30,7.00,'20230908',GETDATE())


USE [PharmacyManagementStore]
GO

INSERT INTO [dbo].[PharmacySales]
           ([PharmacyId],[PharmacistId],[DrugId],[UnitCount],[UnitPrice],[SaleDate],[CreatedDate])
     VALUES
           
		(5,3,2,90,12.50,'20230801',GETDATE()),
		(4,4,3,40,10.50,'20230802',GETDATE()),
		(5,4,5,30,7.00,'20230803',GETDATE()),
		(2,1,1,300,12.50,'20230801',GETDATE()),
		(2,1,3,240,10.50,'20230803',GETDATE()),
		(3,1,2,180,1.50,'20230901',GETDATE()),
		(3,1,6,210,2.00,'20230807',GETDATE()),
		(1,2,5,220,7.00,'20230808',GETDATE()),
		(1,2,2,123,1.50,'20230801',GETDATE()),
		(4,2,1,365,12.50,'20230809',GETDATE()),
		(4,2,5,29,7.00,'20230803',GETDATE()),
		(4,2,7,60,6.00,'20230801',GETDATE()),
		(5,3,4,234,6.50,'20230816',GETDATE()),
		(5,3,7,180,10.50,'20230816',GETDATE()),
		(5,3,5,150,1.50,'20230819',GETDATE()),
		(4,4,7,120,6.00,'20230812',GETDATE()),
		(4,4,3,240,10.50,'20230818',GETDATE()),
		(4,4,6,210,2.00,'20230821',GETDATE()),
		(5,4,1,280,12.50,'20230814',GETDATE()),
		(5,4,7,180,6.00,'20230815',GETDATE()),
		(5,4,2,160,1.50,'20230826',GETDATE()),
		(5,4,6,140,2.00,'20230825',GETDATE()),
		(2,1,3,130,10.50,'20230829',GETDATE()),
		(1,2,5,130,7.00,'20230829',GETDATE())