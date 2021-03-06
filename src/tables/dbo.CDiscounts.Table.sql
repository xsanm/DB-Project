USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CDiscounts]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CDiscounts](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[ResteurantID] [int] NOT NULL,
 CONSTRAINT [PK_CDiscounts] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CDiscounts]  WITH CHECK ADD  CONSTRAINT [FK_CDiscounts_Restaurants] FOREIGN KEY([ResteurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[CDiscounts] CHECK CONSTRAINT [FK_CDiscounts_Restaurants]
GO
ALTER TABLE [dbo].[CDiscounts]  WITH CHECK ADD  CONSTRAINT [CK_CDiscounts_Date] CHECK  (([BeginDate]<=[EndDate]))
GO
ALTER TABLE [dbo].[CDiscounts] CHECK CONSTRAINT [CK_CDiscounts_Date]
GO
