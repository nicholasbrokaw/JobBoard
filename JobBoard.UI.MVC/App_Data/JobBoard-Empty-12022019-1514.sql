/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.5026)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [JobBoard]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Positions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Locations]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
ALTER TABLE [dbo].[Locations] DROP CONSTRAINT IF EXISTS [FK_Locations_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_OpenPositions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
ALTER TABLE [dbo].[Applications] DROP CONSTRAINT IF EXISTS [FK_Applications_ApplicationStatuses]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[UserDetails]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[Positions]
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[OpenPositions]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[Locations]
GO
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[ApplicationStatuses]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 12/2/2019 3:15:29 PM ******/
DROP TABLE IF EXISTS [dbo].[Applications]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 12/2/2019 3:15:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Applications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Applications](
	[ApplicationId] [int] IDENTITY(1,1) NOT NULL,
	[OpenPositionId] [int] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ApplicationDate] [date] NOT NULL,
	[ManagerNotes] [varchar](2000) NULL,
	[ApplicationStatusId] [int] NOT NULL,
	[ResumeFilename] [varchar](75) NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 12/2/2019 3:15:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ApplicationStatuses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ApplicationStatuses](
	[ApplicationStatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_ApplicationStatuses] PRIMARY KEY CLUSTERED 
(
	[ApplicationStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/2/2019 3:15:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Locations](
	[LocationId] [int] IDENTITY(1,1) NOT NULL,
	[OfficeNumber] [varchar](10) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [char](2) NOT NULL,
	[ManagerId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 12/2/2019 3:15:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OpenPositions](
	[OpenPositionId] [int] IDENTITY(1,1) NOT NULL,
	[PositionId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
 CONSTRAINT [PK_OpenPositions] PRIMARY KEY CLUSTERED 
(
	[OpenPositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 12/2/2019 3:15:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Positions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Positions](
	[PositionId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
 CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED 
(
	[PositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 12/2/2019 3:15:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserDetails](
	[UserId] [nvarchar](128) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[ResumeFilename] [varchar](75) NULL,
 CONSTRAINT [PK_UserDetails] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_ApplicationStatuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_ApplicationStatuses] FOREIGN KEY([ApplicationStatusId])
REFERENCES [dbo].[ApplicationStatuses] ([ApplicationStatusId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_ApplicationStatuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_ApplicationStatuses]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_OpenPositions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_OpenPositions] FOREIGN KEY([OpenPositionId])
REFERENCES [dbo].[OpenPositions] ([OpenPositionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_OpenPositions]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_OpenPositions]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications]  WITH CHECK ADD  CONSTRAINT [FK_Applications_UserDetails] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserDetails] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Applications_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Applications]'))
ALTER TABLE [dbo].[Applications] CHECK CONSTRAINT [FK_Applications_UserDetails]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Locations_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Locations]'))
ALTER TABLE [dbo].[Locations]  WITH CHECK ADD  CONSTRAINT [FK_Locations_UserDetails] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[UserDetails] ([UserId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Locations_UserDetails]') AND parent_object_id = OBJECT_ID(N'[dbo].[Locations]'))
ALTER TABLE [dbo].[Locations] CHECK CONSTRAINT [FK_Locations_UserDetails]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Locations]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Locations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Locations]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Locations]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Positions]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions]  WITH CHECK ADD  CONSTRAINT [FK_OpenPositions_Positions] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Positions] ([PositionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OpenPositions_Positions]') AND parent_object_id = OBJECT_ID(N'[dbo].[OpenPositions]'))
ALTER TABLE [dbo].[OpenPositions] CHECK CONSTRAINT [FK_OpenPositions_Positions]
GO
