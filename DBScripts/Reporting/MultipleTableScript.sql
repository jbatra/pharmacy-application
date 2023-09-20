USE [PharmacyManagementStore]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pharmacy]') AND type in (N'U'))
DROP TABLE [dbo].[Pharmacy]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE TABLE [dbo].[Pharmacy](
--	[PharmacyId] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](200) NOT NULL,
--	[Address] [nvarchar](200) NULL,
--	[City] [nvarchar](200) NULL,
--	[State] [nvarchar](200) NULL,
--	[Zip] [nvarchar](12) NULL,
--	[RxFilledMtd] [int] NULL,
--	[CreatedDate] [datetime2](7) NOT NULL,
--	[UpdatedDate] [datetime2](7) NULL,
-- CONSTRAINT [PK_dbo.Pharmacy] PRIMARY KEY CLUSTERED 
--(
--	[PharmacyId] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO

USE [PharmacyManagementStore]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Drug]') AND type in (N'U'))
DROP TABLE [dbo].[Drug]
GO

CREATE TABLE [dbo].[Drug](
	[DrugId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Strength] [nvarchar](20) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,	
 CONSTRAINT [PK_dbo.Drug] PRIMARY KEY CLUSTERED (	[DrugId] ASC )
 ) ON [PRIMARY]
GO

USE [PharmacyManagementStore]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pharmacist]') AND type in (N'U'))
DROP TABLE [dbo].[Pharmacist]
GO

CREATE TABLE [dbo].[Pharmacist](
	[PharmacistId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](200) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,	
 CONSTRAINT [PK_Pharmacist] PRIMARY KEY CLUSTERED ( 	[PharmacistId] ASC )
 ) ON [PRIMARY]
GO

USE [PharmacyManagementStore]
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist] DROP CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacy]
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist] DROP CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacist]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pharmacy_Pharmacist]') AND type in (N'U'))
DROP TABLE [dbo].[Pharmacy_Pharmacist]
GO

CREATE TABLE [dbo].[Pharmacy_Pharmacist](
	[Pharmacy_PharmacistId] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[PharmacistId] [int] NOT NULL,	
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	
 CONSTRAINT [PK_Pharmacy_Pharmacist] PRIMARY KEY CLUSTERED 
(
	[Pharmacy_PharmacistId] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacist] FOREIGN KEY([PharmacistId])
REFERENCES [dbo].[Pharmacist] ([PharmacistId])
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist] CHECK CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacist]
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([PharmacyId])
GO

ALTER TABLE [dbo].[Pharmacy_Pharmacist] CHECK CONSTRAINT [FK_Pharmacy_Pharmacist_Pharmacy]
GO

USE [PharmacyManagementStore]
GO

ALTER TABLE [dbo].[Pharmacy_Drug] DROP CONSTRAINT [FK_Pharmacy_Drug_Pharmacy]
GO

ALTER TABLE [dbo].[Pharmacy_Drug] DROP CONSTRAINT [FK_Pharmacy_Drug_Drug]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pharmacy_Drug]') AND type in (N'U'))
DROP TABLE [dbo].[Pharmacy_Drug]
GO

CREATE TABLE [dbo].[Pharmacy_Drug](
	[Pharmacy_Drug_Id] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[DrugId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[QuantityThreshold] [int] NOT NULL,
	[CreatedDate] [date] NULL,
	[UpdatedDate] [date] NOT NULL,
 CONSTRAINT [PK_Pharmacy_Drug] PRIMARY KEY CLUSTERED 
(
	[Pharmacy_Drug_Id] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Pharmacy_Drug]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_Drug_Drug] FOREIGN KEY([DrugId])
REFERENCES [dbo].[Drug] ([DrugId])
GO

ALTER TABLE [dbo].[Pharmacy_Drug] CHECK CONSTRAINT [FK_Pharmacy_Drug_Drug]
GO

ALTER TABLE [dbo].[Pharmacy_Drug]  WITH CHECK ADD  CONSTRAINT [FK_Pharmacy_Drug_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([PharmacyId])
GO

ALTER TABLE [dbo].[Pharmacy_Drug] CHECK CONSTRAINT [FK_Pharmacy_Drug_Pharmacy]
GO



USE [PharmacyManagementStore]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Warehouse]') AND type in (N'U'))
DROP TABLE [dbo].[Warehouse]
GO

CREATE TABLE [dbo].[Warehouse](
	[WarehouseId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Zip] [nvarchar](20) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Warehouse] PRIMARY KEY CLUSTERED 
(
	[WarehouseId] ASC
)) ON [PRIMARY]
GO


USE [PharmacyManagementStore]
GO

ALTER TABLE [dbo].[Warehouse_Drug] DROP CONSTRAINT [FK_Warehouse_Drug_Warehouse]
GO

ALTER TABLE [dbo].[Warehouse_Drug] DROP CONSTRAINT [FK_Warehouse_Drug_Drug]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Warehouse_Drug]') AND type in (N'U'))
DROP TABLE [dbo].[Warehouse_Drug]
GO

CREATE TABLE [dbo].[Warehouse_Drug](
	[Warehouse_DrugId] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[DrugId] [int] NOT NULL,
	[Quantity] [int] NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
	
 CONSTRAINT [PK_Warehouse_Drug] PRIMARY KEY CLUSTERED 
(
	[Warehouse_DrugId] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Warehouse_Drug]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Drug_Drug] FOREIGN KEY([DrugId])
REFERENCES [dbo].[Drug] ([DrugId])
GO

ALTER TABLE [dbo].[Warehouse_Drug] CHECK CONSTRAINT [FK_Warehouse_Drug_Drug]
GO

ALTER TABLE [dbo].[Warehouse_Drug]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Drug_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([WarehouseId])
GO

ALTER TABLE [dbo].[Warehouse_Drug] CHECK CONSTRAINT [FK_Warehouse_Drug_Warehouse]
GO


USE [PharmacyManagementStore]
GO

ALTER TABLE [dbo].[Delivery] DROP CONSTRAINT [FK_Delivery_Warehouse]
GO

ALTER TABLE [dbo].[Delivery] DROP CONSTRAINT [FK_Delivery_Pharmacy]
GO

ALTER TABLE [dbo].[Delivery] DROP CONSTRAINT [FK_Delivery_Drug]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Delivery]') AND type in (N'U'))
DROP TABLE [dbo].[Delivery]
GO

CREATE TABLE [dbo].[Delivery](
	[DeliveryId] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseId] [int] NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[DrugId] [int] NOT NULL,
	[UnitCount] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[SaleAmount]  AS ([UnitCount]*[UnitPrice]),
	[DeliveryDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Delivery_1] PRIMARY KEY CLUSTERED 
(
	[DeliveryId] ASC
)) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Drug] FOREIGN KEY([DrugId])
REFERENCES [dbo].[Drug] ([DrugId])
GO

ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Drug]
GO

ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([PharmacyId])
GO

ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Pharmacy]
GO

ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_Warehouse] FOREIGN KEY([WarehouseId])
REFERENCES [dbo].[Warehouse] ([WarehouseId])
GO

ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_Warehouse]
GO


USE [PharmacyManagementStore]
GO

ALTER TABLE [dbo].[PharmacySales] DROP CONSTRAINT [FK_PharmacySales_Pharmacy]
GO

ALTER TABLE [dbo].[PharmacySales] DROP CONSTRAINT [FK_PharmacySales_Pharmacist]
GO

ALTER TABLE [dbo].[PharmacySales] DROP CONSTRAINT [FK_PharmacySales_Drug]
GO

ALTER TABLE [dbo].[PharmacySales] DROP CONSTRAINT [DF__PharmacyS__Pharm__3E1D39E1]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PharmacySales]') AND type in (N'U'))
DROP TABLE [dbo].[PharmacySales]
GO

CREATE TABLE [dbo].[PharmacySales](
	[PharmacySalesId] [int] IDENTITY(1,1) NOT NULL,
	[PharmacyId] [int] NOT NULL,
	[PharmacistId] [int] NOT NULL,
	[DrugId] [int] NOT NULL,
	[UnitCount] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[SaleAmount]  AS ([UnitCount]*[UnitPrice]),
	[SaleDate] [date] NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[UpdatedDate] [date] NULL,
 CONSTRAINT [PK_PharmacySales] PRIMARY KEY CLUSTERED 
(
	[PharmacySalesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PharmacySales] ADD  DEFAULT ((1)) FOR [PharmacistId]
GO

ALTER TABLE [dbo].[PharmacySales]  WITH CHECK ADD  CONSTRAINT [FK_PharmacySales_Drug] FOREIGN KEY([DrugId])
REFERENCES [dbo].[Drug] ([DrugId])
GO

ALTER TABLE [dbo].[PharmacySales] CHECK CONSTRAINT [FK_PharmacySales_Drug]
GO

ALTER TABLE [dbo].[PharmacySales]  WITH CHECK ADD  CONSTRAINT [FK_PharmacySales_Pharmacist] FOREIGN KEY([PharmacistId])
REFERENCES [dbo].[Pharmacist] ([PharmacistId])
GO

ALTER TABLE [dbo].[PharmacySales] CHECK CONSTRAINT [FK_PharmacySales_Pharmacist]
GO

ALTER TABLE [dbo].[PharmacySales]  WITH CHECK ADD  CONSTRAINT [FK_PharmacySales_Pharmacy] FOREIGN KEY([PharmacyId])
REFERENCES [dbo].[Pharmacy] ([PharmacyId])
GO

ALTER TABLE [dbo].[PharmacySales] CHECK CONSTRAINT [FK_PharmacySales_Pharmacy]
GO


