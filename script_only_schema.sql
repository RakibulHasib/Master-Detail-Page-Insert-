USE [master]
GO
/****** Object:  Database [TTMSB2]    Script Date: 12/1/2022 10:21:15 AM ******/
CREATE DATABASE [TTMSB2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TTMSB2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TTMSB2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TTMSB2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TTMSB2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TTMSB2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TTMSB2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TTMSB2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TTMSB2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TTMSB2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TTMSB2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TTMSB2] SET ARITHABORT OFF 
GO
ALTER DATABASE [TTMSB2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TTMSB2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TTMSB2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TTMSB2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TTMSB2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TTMSB2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TTMSB2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TTMSB2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TTMSB2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TTMSB2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TTMSB2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TTMSB2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TTMSB2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TTMSB2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TTMSB2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TTMSB2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TTMSB2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TTMSB2] SET RECOVERY FULL 
GO
ALTER DATABASE [TTMSB2] SET  MULTI_USER 
GO
ALTER DATABASE [TTMSB2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TTMSB2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TTMSB2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TTMSB2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TTMSB2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TTMSB2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TTMSB2', N'ON'
GO
ALTER DATABASE [TTMSB2] SET QUERY_STORE = OFF
GO
USE [TTMSB2]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 12/1/2022 10:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[SpotName] [nvarchar](50) NOT NULL,
	[Fee] [money] NOT NULL,
	[Available] [bit] NOT NULL,
	[TypeId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 12/1/2022 10:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](50) NOT NULL,
	[Age] [int] NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Picture] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntrySpots]    Script Date: 12/1/2022 10:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntrySpots](
	[EntrySpotId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[BookingId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EntrySpotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TourType]    Script Date: 12/1/2022 10:21:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourType](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD FOREIGN KEY([TypeId])
REFERENCES [dbo].[TourType] ([TypeId])
GO
ALTER TABLE [dbo].[EntrySpots]  WITH CHECK ADD FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([BookingId])
GO
ALTER TABLE [dbo].[EntrySpots]  WITH CHECK ADD FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
USE [master]
GO
ALTER DATABASE [TTMSB2] SET  READ_WRITE 
GO
