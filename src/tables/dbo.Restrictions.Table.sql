USE [u_kurowski]
GO
/****** Object:  Table [dbo].[Restrictions]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restrictions](
	[TableID] [int] NOT NULL,
	[EndDate] [date] NULL,
	[BeginDate] [date] NOT NULL,
	[PlacesAvailable] [int] NOT NULL,
 CONSTRAINT [PK_Restrictions] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Restrictions]  WITH CHECK ADD  CONSTRAINT [FK_Restrictions_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Table] ([TableID])
GO
ALTER TABLE [dbo].[Restrictions] CHECK CONSTRAINT [FK_Restrictions_Tables]
GO
ALTER TABLE [dbo].[Restrictions]  WITH CHECK ADD  CONSTRAINT [CK_Restrictions] CHECK  (([BeginDate]<=[EndDate] AND [PlacesAvailable]>=(0)))
GO
ALTER TABLE [dbo].[Restrictions] CHECK CONSTRAINT [CK_Restrictions]
GO
