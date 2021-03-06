USE [master]
GO
/****** Object:  Database [AutoTestRepository]    Script Date: 22.10.2015 5:30:09 ******/
CREATE DATABASE [AutoTestRepository]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AutoTestRepository', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AutoTestRepository.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AutoTestRepository_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AutoTestRepository_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AutoTestRepository] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AutoTestRepository].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AutoTestRepository] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AutoTestRepository] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AutoTestRepository] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AutoTestRepository] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AutoTestRepository] SET ARITHABORT OFF 
GO
ALTER DATABASE [AutoTestRepository] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AutoTestRepository] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [AutoTestRepository] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AutoTestRepository] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AutoTestRepository] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AutoTestRepository] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AutoTestRepository] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AutoTestRepository] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AutoTestRepository] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AutoTestRepository] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AutoTestRepository] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AutoTestRepository] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AutoTestRepository] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AutoTestRepository] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AutoTestRepository] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AutoTestRepository] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AutoTestRepository] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AutoTestRepository] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AutoTestRepository] SET RECOVERY FULL 
GO
ALTER DATABASE [AutoTestRepository] SET  MULTI_USER 
GO
ALTER DATABASE [AutoTestRepository] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AutoTestRepository] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AutoTestRepository] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AutoTestRepository] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AutoTestRepository', N'ON'
GO
USE [AutoTestRepository]
GO
/****** Object:  StoredProcedure [dbo].[pGetValue]    Script Date: 22.10.2015 5:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Alex
-- Create date: 2015.10.22
-- Description:	Returns test value by Page Name, test Type and Value Name
-- =============================================
CREATE PROCEDURE [dbo].[pGetValue] 
	@pageName nvarchar(100) = NULL,
	@fieldName nvarchar(100) = NULL,
	@typeName nvarchar(100) = NULL
AS
BEGIN
	DECLARE
		@pageId int = -1,
		@fieldId int = -1,
		@typeId int = -1,
		@query nvarchar(500) = 'SELECT TOP(1) v.[value] FROM [dbo].[tValues] AS v WHERE';

	IF (@pageName IS NOT NULL AND @FieldName IS NOT NULL)
	BEGIN
		SELECT @pageId = p.page_id 
		FROM [dbo].[tPages] AS p 
		WHERE p.page_name = @pageName

		SELECT @fieldId = f.[field_id] 
		FROM [dbo].[tFields] AS f
		INNER JOIN [dbo].[tPages] AS p 
		ON f.[field_name] = @fieldName AND f.[page_id] = @pageId;

		IF (@pageId > 0 AND @fieldId > 0)
		BEGIN
			SET @query = @query + ' v.[field_id] = ' + CONVERT(varchar, @fieldId);
		END
	END

	IF (@typeName IS NOT NULL)
	BEGIN
		SELECT @typeId = t.[type_id]
		FROM [dbo].[tType] AS t
		WHERE t.[type_name] = @typeName

		IF(@typeId > 0)
		BEGIN
			IF (@pageId > 0 AND @fieldId > 0)
			BEGIN
				SET @query = @query + ' AND ';
			END

			SET @query = @query + ' v.[type_id] = ' + CONVERT(varchar, @typeId);
		END
	END

	EXECUTE sp_executesql @query;
END

GO
/****** Object:  Table [dbo].[tFields]    Script Date: 22.10.2015 5:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tFields](
	[field_id] [int] IDENTITY(1,1) NOT NULL,
	[page_id] [int] NOT NULL,
	[field_name] [nvarchar](100) NOT NULL,
	[field_description] [nvarchar](500) NULL,
 CONSTRAINT [PK_tFields] PRIMARY KEY CLUSTERED 
(
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tPages]    Script Date: 22.10.2015 5:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tPages](
	[page_id] [int] IDENTITY(1,1) NOT NULL,
	[page_name] [nvarchar](100) NOT NULL,
	[page_description] [nvarchar](500) NULL,
 CONSTRAINT [PK_tPages] PRIMARY KEY CLUSTERED 
(
	[page_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tType]    Script Date: 22.10.2015 5:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tType](
	[type_id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [nvarchar](100) NOT NULL,
	[type_description] [nvarchar](500) NULL,
 CONSTRAINT [PK_tType] PRIMARY KEY CLUSTERED 
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tValues]    Script Date: 22.10.2015 5:30:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tValues](
	[value_id] [int] IDENTITY(1,1) NOT NULL,
	[field_id] [int] NOT NULL,
	[type_id] [int] NOT NULL,
	[value] [nvarchar](max) NULL,
 CONSTRAINT [PK_tValues] PRIMARY KEY CLUSTERED 
(
	[value_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[tFields]  WITH CHECK ADD  CONSTRAINT [FK_tFields_tPages] FOREIGN KEY([page_id])
REFERENCES [dbo].[tPages] ([page_id])
GO
ALTER TABLE [dbo].[tFields] CHECK CONSTRAINT [FK_tFields_tPages]
GO
ALTER TABLE [dbo].[tValues]  WITH CHECK ADD  CONSTRAINT [FK_tValues_tFields] FOREIGN KEY([field_id])
REFERENCES [dbo].[tFields] ([field_id])
GO
ALTER TABLE [dbo].[tValues] CHECK CONSTRAINT [FK_tValues_tFields]
GO
ALTER TABLE [dbo].[tValues]  WITH CHECK ADD  CONSTRAINT [FK_tValues_tType] FOREIGN KEY([type_id])
REFERENCES [dbo].[tType] ([type_id])
GO
ALTER TABLE [dbo].[tValues] CHECK CONSTRAINT [FK_tValues_tType]
GO
USE [master]
GO
ALTER DATABASE [AutoTestRepository] SET  READ_WRITE 
GO
