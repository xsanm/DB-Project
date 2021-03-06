USE [u_kurowski]
GO
/****** Object:  Table [dbo].[IndividualDiscountsOnce]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndividualDiscountsOnce](
	[DiscountID] [int] NOT NULL,
	[K2] [money] NOT NULL,
	[D1] [int] NOT NULL,
	[R2] [float] NOT NULL,
 CONSTRAINT [PK_IndyvidualDiscountsOnce] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IndividualDiscountsOnce]  WITH CHECK ADD  CONSTRAINT [FK_IndividualDiscountsOnce_IDiscount] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[IDiscount] ([DiscountID])
GO
ALTER TABLE [dbo].[IndividualDiscountsOnce] CHECK CONSTRAINT [FK_IndividualDiscountsOnce_IDiscount]
GO
ALTER TABLE [dbo].[IndividualDiscountsOnce]  WITH CHECK ADD  CONSTRAINT [CK_IndyvidualDiscountsOnce] CHECK  (([K2]>=(0) AND [D1]>(0) AND ([R2]>=(0) AND [R2]<=(1))))
GO
ALTER TABLE [dbo].[IndividualDiscountsOnce] CHECK CONSTRAINT [CK_IndyvidualDiscountsOnce]
GO
