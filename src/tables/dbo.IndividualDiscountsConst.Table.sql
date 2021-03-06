USE [u_kurowski]
GO
/****** Object:  Table [dbo].[IndividualDiscountsConst]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndividualDiscountsConst](
	[DiscountID] [int] NOT NULL,
	[Z1] [int] NOT NULL,
	[K1] [money] NOT NULL,
	[R1] [float] NOT NULL,
 CONSTRAINT [PK_IndividualDiscountsConst] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IndividualDiscountsConst]  WITH CHECK ADD  CONSTRAINT [FK_IndividualDiscountsConst_IDiscount1] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[IDiscount] ([DiscountID])
GO
ALTER TABLE [dbo].[IndividualDiscountsConst] CHECK CONSTRAINT [FK_IndividualDiscountsConst_IDiscount1]
GO
ALTER TABLE [dbo].[IndividualDiscountsConst]  WITH CHECK ADD  CONSTRAINT [CK_IndividualDiscountsConst_Parameters] CHECK  (([Z1]>(0) AND [K1]>=(0) AND ([R1]>=(0) AND [R1]<=(1))))
GO
ALTER TABLE [dbo].[IndividualDiscountsConst] CHECK CONSTRAINT [CK_IndividualDiscountsConst_Parameters]
GO
