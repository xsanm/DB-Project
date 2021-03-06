USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Ingredients]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredients](
	[IngredientID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Unit] [varchar](50) NOT NULL,
	[UnitsInStock] [int] NOT NULL,
	[UnitsReserved] [int] NOT NULL,
	[OnRequest] [bit] NOT NULL,
	[ResturantID] [int] NOT NULL,
 CONSTRAINT [PK_Ingredients] PRIMARY KEY CLUSTERED 
(
	[IngredientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ingredients]  WITH CHECK ADD  CONSTRAINT [FK_Ingredients_Restaurants] FOREIGN KEY([ResturantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Ingredients] CHECK CONSTRAINT [FK_Ingredients_Restaurants]
GO
ALTER TABLE [dbo].[Ingredients]  WITH CHECK ADD  CONSTRAINT [CK_Ingredients] CHECK  ((NOT [Unit] like '' AND NOT [Name] like '' AND [UnitsInStock]>=(0) AND [UnitsReserved]>=(0) AND ([OnRequest]=(1) OR [UnitsReserved]<=[UnitsInStock])))
GO
ALTER TABLE [dbo].[Ingredients] CHECK CONSTRAINT [CK_Ingredients]
GO
