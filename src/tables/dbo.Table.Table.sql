USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[TableID] [int] IDENTITY(1,1) NOT NULL,
	[Places] [int] NOT NULL,
	[ResturantID] [int] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Restaurants] FOREIGN KEY([ResturantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Table] CHECK CONSTRAINT [FK_Tables_Restaurants]
GO
ALTER TABLE [dbo].[Table]  WITH CHECK ADD  CONSTRAINT [CK_Tables] CHECK  (([Places]>=(0)))
GO
ALTER TABLE [dbo].[Table] CHECK CONSTRAINT [CK_Tables]
GO
