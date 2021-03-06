USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(2000,1) NOT NULL,
	[ItemID] [int] NOT NULL,
	[DateBegin] [date] NOT NULL,
	[DateEnd] [date] NULL,
	[ResturantID] [int] NOT NULL,
 CONSTRAINT [PK_MenuHistory] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_MenuItem] FOREIGN KEY([ItemID])
REFERENCES [dbo].[MenuItem] ([ItemID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_MenuItem]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [FK_Menu_Restaurants] FOREIGN KEY([ResturantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [FK_Menu_Restaurants]
GO
ALTER TABLE [dbo].[Menu]  WITH CHECK ADD  CONSTRAINT [CK_Menu] CHECK  (([DateEnd] IS NULL OR [DateBegin]<=[DateEnd]))
GO
ALTER TABLE [dbo].[Menu] CHECK CONSTRAINT [CK_Menu]
GO
