USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[RestaurantID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantName] [varchar](50) NOT NULL,
	[Adress] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[RestaurantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Restaurants]  WITH CHECK ADD  CONSTRAINT [CK_Restaurants] CHECK  (([Adress] like '%[0-9][0-9]-[0-9][0-9][0-9]%' AND NOT [RestaurantName] like ''))
GO
ALTER TABLE [dbo].[Restaurants] CHECK CONSTRAINT [CK_Restaurants]
GO
