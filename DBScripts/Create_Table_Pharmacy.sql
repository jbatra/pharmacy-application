USE [PharmacyManagementStore]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pharmacy]') AND type in (N'U'))
DROP TABLE [dbo].[Pharmacy]
GO


CREATE TABLE [dbo].[Pharmacy](
	[PharmacyId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Address] [nvarchar](200) NULL,
	[City] [nvarchar](200) NULL,
	[State] [nvarchar](200) NULL,
	[Zip] [nvarchar](12) NULL,
	[RxFilledMTD] [int] NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_dbo.Pharmacy] PRIMARY KEY CLUSTERED ([PharmacyId] ASC)
) ON [PRIMARY]
GO


