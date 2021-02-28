USE [master]
GO
/****** Object:  Database [u_kurowski]    Script Date: 28.11.2020 18:46:32 ******/
CREATE DATABASE [u_kurowski]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'u_kurowski', FILENAME = N'/var/opt/mssql/data/u_kurowski.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'u_kurowski_log', FILENAME = N'/var/opt/mssql/data/u_kurowski_log.ldf' , SIZE = 66048KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [u_kurowski] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [u_kurowski].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [u_kurowski] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [u_kurowski] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [u_kurowski] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [u_kurowski] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [u_kurowski] SET ARITHABORT OFF 
GO
ALTER DATABASE [u_kurowski] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [u_kurowski] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [u_kurowski] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [u_kurowski] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [u_kurowski] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [u_kurowski] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [u_kurowski] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [u_kurowski] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [u_kurowski] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [u_kurowski] SET  ENABLE_BROKER 
GO
ALTER DATABASE [u_kurowski] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [u_kurowski] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [u_kurowski] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [u_kurowski] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [u_kurowski] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [u_kurowski] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [u_kurowski] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [u_kurowski] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [u_kurowski] SET  MULTI_USER 
GO
ALTER DATABASE [u_kurowski] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [u_kurowski] SET DB_CHAINING OFF 
GO
ALTER DATABASE [u_kurowski] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [u_kurowski] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [u_kurowski] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [u_kurowski] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [u_kurowski] SET QUERY_STORE = OFF
GO
USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyCustomer]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyCustomer](
	[CustomerID] [int] NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[NIP] [nchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDiscount]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDiscount](
	[CoustomerID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[ExprDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discounts]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discounts](
	[DiscountID] [int] NOT NULL,
	[DiscountType] [tinyint] NOT NULL,
 CONSTRAINT [PK_Discounts] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IndywidualCustomer]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndywidualCustomer](
	[CustomerID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredients]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredients](
	[IngredientID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Unit] [varchar](50) NOT NULL,
	[UnitsInStock] [int] NOT NULL,
	[UnitsReserved] [int] NOT NULL,
	[OnRequest] [bit] NOT NULL,
 CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED 
(
	[IngredientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[PositionID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[DateBegin] [date] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuHistory]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuHistory](
	[HistoryID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[DateBegin] [date] NOT NULL,
	[DateEnd] [date] NOT NULL,
 CONSTRAINT [PK_MenuHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuItem]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItem](
	[ItemID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Cost] [money] NOT NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_MenuItem] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ResrvationID] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[ReservationDate] [date] NOT NULL,
	[RealizationDate] [date] NULL,
	[Type] [bit] NOT NULL,
	[PaymentType] [varchar](50) NOT NULL,
	[Sum] [money] NOT NULL,
	[PaymentDate] [date] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[IngredientID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[Amount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[People] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[SecondName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restrictions]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restrictions](
	[RestrictionID] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[PercentValue] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 28.11.2020 18:46:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[TableID] [int] NOT NULL,
	[Places] [int] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyCustomer]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCustomer_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[CompanyCustomer] CHECK CONSTRAINT [FK_CompanyCustomer_Customer]
GO
ALTER TABLE [dbo].[CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscount_Customer] FOREIGN KEY([CoustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[CustomerDiscount] CHECK CONSTRAINT [FK_CustomerDiscount_Customer]
GO
ALTER TABLE [dbo].[CustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CustomerDiscount_Discounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[Discounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CustomerDiscount] CHECK CONSTRAINT [FK_CustomerDiscount_Discounts]
GO
ALTER TABLE [dbo].[IndywidualCustomer]  WITH CHECK ADD  CONSTRAINT [FK_IndywidualCustomer_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[IndywidualCustomer] CHECK CONSTRAINT [FK_IndywidualCustomer_Customer]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_MenuItem] FOREIGN KEY([ItemID])
REFERENCES [dbo].[MenuItem] ([ItemID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_MenuItem]
GO
ALTER TABLE [dbo].[MenuHistory]  WITH CHECK ADD  CONSTRAINT [FK_MenuHistory_MenuItem] FOREIGN KEY([ItemID])
REFERENCES [dbo].[MenuItem] ([ItemID])
GO
ALTER TABLE [dbo].[MenuHistory] CHECK CONSTRAINT [FK_MenuHistory_MenuItem]
GO
ALTER TABLE [dbo].[MenuItem]  WITH CHECK ADD  CONSTRAINT [FK_MenuItem_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[MenuItem] CHECK CONSTRAINT [FK_MenuItem_Category]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_MenuItem] FOREIGN KEY([ItemID])
REFERENCES [dbo].[MenuItem] ([ItemID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_MenuItem]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customer]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Reservations] FOREIGN KEY([ResrvationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Reservations]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK_Recipe_Ingredients] FOREIGN KEY([IngredientID])
REFERENCES [dbo].[Ingredients] ([IngredientID])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK_Recipe_Ingredients]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK_Recipe_MenuItem] FOREIGN KEY([ItemID])
REFERENCES [dbo].[MenuItem] ([ItemID])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK_Recipe_MenuItem]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Tables]
GO
USE [master]
GO
ALTER DATABASE [u_kurowski] SET  READ_WRITE 
GO
