USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CompanyDiscountQuarter]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyDiscountQuarter](
	[DiscountID] [int] NOT NULL,
	[FK2] [money] NOT NULL,
	[FR2] [float] NOT NULL,
 CONSTRAINT [PK_CompanyDiscountQuarter] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyDiscountQuarter]  WITH CHECK ADD  CONSTRAINT [FK_CompanyDiscountQuarter_CDiscounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[CDiscounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CompanyDiscountQuarter] CHECK CONSTRAINT [FK_CompanyDiscountQuarter_CDiscounts]
GO
ALTER TABLE [dbo].[CompanyDiscountQuarter]  WITH CHECK ADD  CONSTRAINT [CK_CompanyDiscountQuarter_Parameters] CHECK  (([FK2]>(0) AND ([FR2]>=(0) AND [FR2]<=(1))))
GO
ALTER TABLE [dbo].[CompanyDiscountQuarter] CHECK CONSTRAINT [CK_CompanyDiscountQuarter_Parameters]
GO
