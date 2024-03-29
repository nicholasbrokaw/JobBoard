/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.5026)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Positions]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpenPositions]') AND type in (N'U'))
ALTER TABLE [dbo].[OpenPositions] DROP CONSTRAINT IF EXISTS [FK_OpenPositions_Locations]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Locations]') AND type in (N'U'))
ALTER TABLE [dbo].[Locations] DROP CONSTRAINT IF EXISTS [FK_Locations_UserDetails]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserRoles] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserLogins] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
ALTER TABLE [dbo].[AspNetUserClaims] DROP CONSTRAINT IF EXISTS [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
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
/****** Object:  Index [UserNameIndex]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [UserNameIndex] ON [dbo].[AspNetUsers]
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [IX_UserId] ON [dbo].[AspNetUserRoles]
GO
/****** Object:  Index [IX_RoleId]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [IX_RoleId] ON [dbo].[AspNetUserRoles]
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [IX_UserId] ON [dbo].[AspNetUserLogins]
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [IX_UserId] ON [dbo].[AspNetUserClaims]
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP INDEX IF EXISTS [RoleNameIndex] ON [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[UserDetails]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[Positions]
GO
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[OpenPositions]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[Locations]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUsers]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserRoles]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserLogins]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetUserClaims]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[AspNetRoles]
GO
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[ApplicationStatuses]
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[Applications]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP TABLE IF EXISTS [dbo].[__MigrationHistory]
GO
/****** Object:  Database [JobBoard]    Script Date: 12/11/2019 8:39:49 AM ******/
DROP DATABASE IF EXISTS [JobBoard]
GO
/****** Object:  Database [JobBoard]    Script Date: 12/11/2019 8:39:49 AM ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'JobBoard')
BEGIN
CREATE DATABASE [JobBoard]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FSDPJobBoard', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FSDPJobBoard.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FSDPJobBoard_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\FSDPJobBoard_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [JobBoard] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JobBoard].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JobBoard] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JobBoard] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JobBoard] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JobBoard] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JobBoard] SET ARITHABORT OFF 
GO
ALTER DATABASE [JobBoard] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [JobBoard] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JobBoard] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JobBoard] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JobBoard] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JobBoard] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JobBoard] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JobBoard] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JobBoard] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JobBoard] SET  DISABLE_BROKER 
GO
ALTER DATABASE [JobBoard] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JobBoard] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JobBoard] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JobBoard] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JobBoard] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JobBoard] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [JobBoard] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JobBoard] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [JobBoard] SET  MULTI_USER 
GO
ALTER DATABASE [JobBoard] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JobBoard] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JobBoard] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JobBoard] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [JobBoard] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [JobBoard] SET QUERY_STORE = OFF
GO
USE [JobBoard]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__MigrationHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Applications]    Script Date: 12/11/2019 8:39:49 AM ******/
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
/****** Object:  Table [dbo].[ApplicationStatuses]    Script Date: 12/11/2019 8:39:49 AM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 12/11/2019 8:39:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/11/2019 8:39:49 AM ******/
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
/****** Object:  Table [dbo].[OpenPositions]    Script Date: 12/11/2019 8:39:49 AM ******/
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
/****** Object:  Table [dbo].[Positions]    Script Date: 12/11/2019 8:39:49 AM ******/
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
/****** Object:  Table [dbo].[UserDetails]    Script Date: 12/11/2019 8:39:49 AM ******/
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
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201912022038389_InitialCreate', N'JobBoard.UI.MVC.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EE338127D5F60FF41D0D3EE2263E532DDE80DEC19A49D6426BB9D0BDA4963DF1AB4443B424BA446A2320916F365FB309F34BFB0458992255E74B115DB1934D0B0C8E2A962B148168BC5FCF1BFDFC73F3E8781F584E3C4A764621F8D0E6D0B13977A3E594EEC942DBEFB60FFF8C35FFF32BEF0C267EB4B4177C2E9A0254926F62363D1A9E324EE230E51320A7D37A6095DB0914B430779D4393E3CFCA77374E46080B001CBB2C69F53C2FC10671FF039A5C4C5114B51704D3D1C24A21C6A6619AA7583429C44C8C513FB5F74FE91A2D81B3D5C8DAEBF4C47790BDB3A0B7C04D2CC70B0B02D4408658881ACA70F099EB19892E52C820214DCBF4418E8162848B0E8C3E98ABC6B770E8F79779C55C302CA4D1346C39E804727423F8EDC7C2D2DDBA5FE408317A069F6C27B9D6971625F79382BFA4C035080CCF0741AC49C78625F972CCE92E806B351D17094435EC600F72B8DBF8DAA880756E77607A53D1D8F0EF9BF036B9A062C8DF184E094C52838B0EED279E0BBFFC62FF7F41B269393A3F9E2E4C3BBF7C83B79FF3D3E7957ED29F415E86A05507417D308C7201B5E94FDB72DA7DECE911B96CD2A6D72AD802DC1D4B0AD6BF4FC0993257B844973FCC1B62EFD67EC1525C2B81E880F33091AB13885CF9B3408D03CC065BDD3C893FFDFC0F5F8DDFB41B8DEA0277F990DBDC41F264E0CF3EA330EB2DAE4D18FF2E9551BEFAF82EC32A621FFAEDB575EFB7546D3D8E59DA146927B142F31AB4B377656C6DBC9A439D4F0665DA0EEBF69734955F3D692F20EAD33130A16DB9E0D85BCAFCBB7B3C59D45110C5E665A5C234D06A7DFB04612C28125D1AD4CE8A8AB0911E8DA9F7945BC08911F0CB02476E0021EC9C28F435CF6F223050344A4B7CC7728496045F07E46C96383E8F07300D167D84D6330D4194361F4EADCEE1E29C1376938E7F6BF3D5E830DCDFDAFF412B98CC61784B7DA18EF1375BFD1945D10EF1C31FCC0DC02907FDEFB61778041C439735D9C249760CCD89B5270B80BC02BC24E8E7BC3F1456AD72EC934407EA8F749A4E5F46B41BAF24BF4148A6F6220D3F9274DA27EA24B9F7413B520358B9A53B48A2AC8FA8ACAC1BA492A28CD826604AD72E65483797CD9080DEFF265B0FBEFF36DB6799BD6828A1A67B042E29F30C1312C63DE1D620CC76435025DD68D5D380BD9F071A6AFBE37659CBEA0201D9AD55AB3215B04869F0D19ECFECF864C4C287EF23DEE9574380815C400DF895E7FC66A9F739264DB9E0EB56E6E9BF976D600D374394B12EAFAD92CD084C04400A32E3FF870567B3423EF8D1C11818E81A1FB7CCB8312E89B2D1BD52D39C70166D83A73F310E114252EF254354287BC1E82153BAA46B05564A42EDC3F149E60E938E68D103F042530537DC2D469E113D78F50D0AA25A965C72D8CF7BDE421D79CE30813CEB055135D98EB03215C80928F34286D1A1A3B158B6B364483D76A1AF336177635EE4A7C622B36D9E23B1BEC52F86FAF6298CD1ADB827136ABA48B00C6A0DE2E0C549C55BA1A807C70D93703954E4C0603152ED5560CB4AEB11D18685D256FCE40F3236AD7F197CEABFB669EF583F2F6B7F54675EDC0366BFAD833D3CC7D4F68C3A0058E55F33C9FF34AFCCC34873390539CCF12E1EACA26C2C16798D543362B7F57EB873ACD20B2113501AE0CAD05545C072A40CA84EA215C11CB6B944E78113D608BB85B23AC58FB25D88A0DA8D8D56BD10AA1F9F25436CE4EA78FB267A5352846DEE9B050C1D11884BC78D53BDE4129A6B8ACAA982EBE701F6FB8D23131180D0A6AF15C0D4A2A3A33B8960AD36CD792CE21EBE3926DA425C97D3268A9E8CCE05A1236DAAE248D53D0C32DD84845F52D7CA0C956443ACADDA6AC1B3B79C69428183B86D4AAF1358A229F2C2BA956A2C49AE57956D3EF66FD938FC21CC371134D0E52296DC989D1182DB1540BAC41D24B3F4ED83962688E789C67EA850A99766F352CFF05CBEAF6A90E62B10F14D4FC77DEC270895FDB6F558744E05C422F43EED564A1748D0DE89B5B3CFD0D0528D644EFA73448436276B2CCADF33BBC6AFBBC4445183B92FC8A13A5684C7175EBEAEF3438EAC41870A04A3F66FDC1324398545E78A155A59B3C53334A11A8AAA29882573B1B3C9343D37BC0647FB1FF78B522BCCEFC12492A550051D413A392E7A08055EABAA3D65351AA98F59AEE8852BE491552AAEA216535ABA42664B5622D3C8346F514DD39A879245574B5B63BB226A3A40AADA95E035B23B35CD71D5593745205D65477C75E65A0C80BE91EEF60C653CC465B587ED8DD6C0F3360BCCEAA38CC1658B9D3AF02558A7B62895B7B054C94EFA545194F7C1B59541EE7D8CCA20C18E615A876235E5F801AAFF1CD98B56BEEDA22DF74CD6FC6EB67B7AF6A1DCAA14F2629B997873FE990371607AEF64736CA092C27B1AD428DB0C1BF240C87234E309AFD124C031FF3E5BC20B846C45FE084E5A91DF6F1E1D1B1F446677FDECB3849E2059A03ABE9D14C7DCCB690A5459E50EC3EA258CD99D8E04DC90A5409475F110F3F4FECFF66AD4EB3C806FF95151F5857C903F17F49A1E23E4EB1F59B9A033A4C8E7D87571DA5A0BFBD89E712DD557EF59FAF79D303EB3686E9746A1D4A8A5E67F8EB8F287A499337DD409AB59F56BCDDD9567BAFA0459566CBFACF13E63E1BE4694221E5DF42F4FCF7BEA2699F1F6C84A879623014DE202A343D215807CBF87CC0834F963D1FE8D759FD73827544333E25F0497F30F92141F765A868B9C37D487368DAC69294E9B935117BA3ACCC5DEF4D4ABEF646135DCDC9EE013768DEF5662ECA1BCB671E6CEBD4A42B0F86BD4BBB7FF51CE57D494B5E39EDBBCD46DE660272C3E5D29F2AEF780F32E534993FBBCF2EDEB6AD99A2C07B9EA2D92F8778CF8C4D6CF3BBCF14DEB6B19902C47B6E6CBDF281F7CCD676B57FEED8D23A6FA13BCFEE5513950CB739BA28725BF66E1E7287E3FF9C8211E41E65FEE8529F2ED694EADAC2704562666ACE5393192B1347E1AB5034B3EDD757B1E1377656D034B335647736F116EB7F236F41D3CCDB9033B98BBC636DD6A22E17BC651D6B4AA57A4B79C6B59EB4A4B5B7F9AC8D57F36F29AD7810A5D4668FE176F9ED64110FA29221A74E8FAC61F5A218F6CECADF6C84FD3BF1972B08FE171C09766BBB6649734516B4D8BC25890A122942738D19F2604B3D8B99BF402E836A1E80CE5E8D67413D7E0D32C7DE15B94D599432E8320EE7412DE0C59D8026FE596A745DE6F16DC4BF9221BA0062FA3C707F4B3EA67EE095725F6A62420608EE5D88702F1F4BC6C3BECB9712E986928E40427DA553748FC32800B0E496CCD0135E473630BF4F7889DC975504D004D23E1075B58FCF7DB48C5198088C557BF8041BF6C2E71FFE0F3D7264D2BA540000, N'6.2.0-61023')
SET IDENTITY_INSERT [dbo].[Applications] ON 

INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (1, 10, N'1fba378e-208b-461f-b10a-56e17e189de6', CAST(N'2019-12-04' AS Date), NULL, 3, N'9f7b3058-81b8-4ed6-ac38-d7db9c58a699.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (2, 10, N'079893e7-db96-419d-b577-43cacb8565d6', CAST(N'2019-12-04' AS Date), N'I''m not sure about this candidate. I''ll look it over later.', 4, N'21e6decf-157d-4bb1-ab7c-32ea123f3450.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (3, 11, N'1fba378e-208b-461f-b10a-56e17e189de6', CAST(N'2019-12-04' AS Date), NULL, 3, N'9f7b3058-81b8-4ed6-ac38-d7db9c58a699.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (4, 12, N'1fba378e-208b-461f-b10a-56e17e189de6', CAST(N'2019-12-04' AS Date), N'Changed notes.', 2, N'9f7b3058-81b8-4ed6-ac38-d7db9c58a699.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (5, 12, N'079893e7-db96-419d-b577-43cacb8565d6', CAST(N'2019-12-04' AS Date), NULL, 4, N'21e6decf-157d-4bb1-ab7c-32ea123f3450.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (6, 13, N'1fba378e-208b-461f-b10a-56e17e189de6', CAST(N'2019-12-04' AS Date), NULL, 2, N'9f7b3058-81b8-4ed6-ac38-d7db9c58a699.pdf')
INSERT [dbo].[Applications] ([ApplicationId], [OpenPositionId], [UserId], [ApplicationDate], [ManagerNotes], [ApplicationStatusId], [ResumeFilename]) VALUES (7, 13, N'079893e7-db96-419d-b577-43cacb8565d6', CAST(N'2019-12-04' AS Date), NULL, 2, N'21e6decf-157d-4bb1-ab7c-32ea123f3450.pdf')
SET IDENTITY_INSERT [dbo].[Applications] OFF
SET IDENTITY_INSERT [dbo].[ApplicationStatuses] ON 

INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [Description]) VALUES (2, N'Pending', N'The application is waiting to be reviewed by a manager.')
INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [Description]) VALUES (3, N'Approved', N'The application has been approved.')
INSERT [dbo].[ApplicationStatuses] ([ApplicationStatusId], [StatusName], [Description]) VALUES (4, N'Rejected', N'The application has been rejected.')
SET IDENTITY_INSERT [dbo].[ApplicationStatuses] OFF
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'f6af5574-1623-440e-a092-f51fc92c8c29', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'457698a0-f2b8-4df6-b903-33d9e7e5bd7e', N'Employee')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'15a576b0-f5e1-49a8-a62c-50f3dc0805e5', N'Manager')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'304b9a2f-4661-40e8-8210-4baed5a4776f', N'Test')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'418a42e5-2951-4e97-919b-89a172deb30c', N'15a576b0-f5e1-49a8-a62c-50f3dc0805e5')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'95b13970-4744-459a-b4d3-59c138c23859', N'15a576b0-f5e1-49a8-a62c-50f3dc0805e5')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'fcaed90c-d7fb-45e7-98fc-9d442a197545', N'15a576b0-f5e1-49a8-a62c-50f3dc0805e5')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'079893e7-db96-419d-b577-43cacb8565d6', N'457698a0-f2b8-4df6-b903-33d9e7e5bd7e')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'1fba378e-208b-461f-b10a-56e17e189de6', N'457698a0-f2b8-4df6-b903-33d9e7e5bd7e')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'133b7234-a5b1-4c70-be29-23e40ad0dc64', N'f6af5574-1623-440e-a092-f51fc92c8c29')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'079893e7-db96-419d-b577-43cacb8565d6', N'employee2@victisoft.com', 0, N'AO0dUmoTtM/ldGCqUDMc/KiZUAi+fK8dI7VckIfpuLqydxhHxQD4bCvWgfScVf/GrA==', N'2cc5c5b3-4232-40cc-919b-a7b8cff05549', NULL, 0, 0, NULL, 1, 0, N'employee2@victisoft.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'133b7234-a5b1-4c70-be29-23e40ad0dc64', N'admin1@victisoft.com', 0, N'ALbWeIKl5i1WuUXgmnyGVON22xePnDHfO1zd1+Pie9hLIY3MLe8hXQmufV+mrz0rFg==', N'e085b0f8-bf60-4bb4-b9d8-af9eff3eba8d', NULL, 0, 0, NULL, 1, 0, N'admin1@victisoft.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'1fba378e-208b-461f-b10a-56e17e189de6', N'employee1@victisoft.com', 0, N'AFMCVod3ijCNAqmsRasr+O/kKVeJXpoigVj7x6xxbWnX2XeAg+PnF5jn9HHzujcNtA==', N'191768a0-84d6-45bf-814a-5b0dfbfec95f', NULL, 0, 0, NULL, 1, 0, N'employee1@victisoft.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'418a42e5-2951-4e97-919b-89a172deb30c', N'manager2@victisoft.com', 0, N'ALaec1Jhm9t6OqOG5pU+9CvO8HAW4FOUkybVjIoA20Cl6Z9ArdpGvuiymlOGOb2aQg==', N'8be2e50b-ca1a-4f2c-95e1-590292401fcb', NULL, 0, 0, NULL, 1, 0, N'manager2@victisoft.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'95b13970-4744-459a-b4d3-59c138c23859', N'employee3@victisoft.com', 0, N'ANoVyhHz1OqFU2nS3Kp3QLxg6Lxlfi6hE38KGC+ertkcBmYR34EITwVJdfhYoOl7Ig==', N'da373fe3-b3df-4638-8f43-ae1c7a247b30', NULL, 0, 0, NULL, 1, 0, N'employee3@victisoft.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'fcaed90c-d7fb-45e7-98fc-9d442a197545', N'manager1@victisoft.com', 0, N'AI4YadJle58kzazALvVc3UvkZS2J6XkiqP9YyerFpq80qJmaigiqMmWKKI5kPIrBzQ==', N'5e2dbe42-665e-4e4e-92ff-ec19829dd0e6', NULL, 0, 0, NULL, 1, 0, N'manager1@victisoft.com')
SET IDENTITY_INSERT [dbo].[Locations] ON 

INSERT [dbo].[Locations] ([LocationId], [OfficeNumber], [City], [State], [ManagerId]) VALUES (5, N'1', N'Burlington', N'IA', N'fcaed90c-d7fb-45e7-98fc-9d442a197545')
INSERT [dbo].[Locations] ([LocationId], [OfficeNumber], [City], [State], [ManagerId]) VALUES (6, N'2', N'San Fransisco', N'CA', N'418a42e5-2951-4e97-919b-89a172deb30c')
INSERT [dbo].[Locations] ([LocationId], [OfficeNumber], [City], [State], [ManagerId]) VALUES (8, N'3', N'Gilroy', N'CA', N'95b13970-4744-459a-b4d3-59c138c23859')
SET IDENTITY_INSERT [dbo].[Locations] OFF
SET IDENTITY_INSERT [dbo].[OpenPositions] ON 

INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (10, 5, 5)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (11, 6, 6)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (12, 7, 6)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (13, 7, 5)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (19, 9, 5)
INSERT [dbo].[OpenPositions] ([OpenPositionId], [PositionId], [LocationId]) VALUES (20, 9, 6)
SET IDENTITY_INSERT [dbo].[OpenPositions] OFF
SET IDENTITY_INSERT [dbo].[Positions] ON 

INSERT [dbo].[Positions] ([PositionId], [Title], [Description]) VALUES (5, N'Jr. Software Engineer', N'In this role, you will be required to...')
INSERT [dbo].[Positions] ([PositionId], [Title], [Description]) VALUES (6, N'Sr. Software Engineer', N'In this role, you will be required to...')
INSERT [dbo].[Positions] ([PositionId], [Title], [Description]) VALUES (7, N'Front End Developer', N'In this role, you will be required to...')
INSERT [dbo].[Positions] ([PositionId], [Title], [Description]) VALUES (9, N'Test', N'Just testing.')
INSERT [dbo].[Positions] ([PositionId], [Title], [Description]) VALUES (10, N'Test 2', N'Really long description! alsd kjfalksjd fkljals kdjflkas jd;fljasd;lk fja;skdjf aksj df;akjsd;fkj  as ;dkfj a;lksdjfkl ajsd f;lkaj s dlfkj alsdkjf; lakjsdf;lakjsd;flkjas;kldjf;lakjdf;lkajsd;lkfja;slkdjf;laksjdf;lasjkdf')
SET IDENTITY_INSERT [dbo].[Positions] OFF
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'079893e7-db96-419d-b577-43cacb8565d6', N'Alex', N'Christian', N'21e6decf-157d-4bb1-ab7c-32ea123f3450.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'133b7234-a5b1-4c70-be29-23e40ad0dc64', N'Nicholas', N'Brokaw', N'5cea8693-636f-4175-ace9-2733a9cd1247.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'1fba378e-208b-461f-b10a-56e17e189de6', N'Drake', N'Taylor', N'9f7b3058-81b8-4ed6-ac38-d7db9c58a699.pdf')
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'418a42e5-2951-4e97-919b-89a172deb30c', N'Parker', N'Tenove', NULL)
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'95b13970-4744-459a-b4d3-59c138c23859', N'Tyler', N'Sharman', NULL)
INSERT [dbo].[UserDetails] ([UserId], [FirstName], [LastName], [ResumeFilename]) VALUES (N'fcaed90c-d7fb-45e7-98fc-9d442a197545', N'Jack', N'Riley', N'7e295d01-2ffc-4352-aa93-3a19890df22b.pdf')
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetRoles]') AND name = N'RoleNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND name = N'IX_RoleId')
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]') AND name = N'IX_UserId')
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 12/11/2019 8:39:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AspNetUsers]') AND name = N'UserNameIndex')
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserClaims]'))
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserLogins]'))
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]') AND parent_object_id = OBJECT_ID(N'[dbo].[AspNetUserRoles]'))
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
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
ALTER DATABASE [JobBoard] SET  READ_WRITE 
GO
