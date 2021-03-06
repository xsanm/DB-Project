USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CompanyDiscountMonthly]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyDiscountMonthly](
	[DiscountID] [int] NOT NULL,
	[FZ] [int] NOT NULL,
	[FK1] [money] NOT NULL,
	[FR1] [float] NOT NULL,
	[FM] [float] NOT NULL,
 CONSTRAINT [PK_CompanyDiscountMonthly] PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyDiscountMonthly]  WITH CHECK ADD  CONSTRAINT [FK_CompanyDiscountMonthly_CDiscounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[CDiscounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CompanyDiscountMonthly] CHECK CONSTRAINT [FK_CompanyDiscountMonthly_CDiscounts]
GO
ALTER TABLE [dbo].[CompanyDiscountMonthly]  WITH CHECK ADD  CONSTRAINT [CK_Parameters] CHECK  (([FZ]>=(0) AND [FK1]>=(0) AND ([FR1]>=(0) AND [FR1]<=(1)) AND ([FM]>=(0) AND [FM]<=(1))))
GO
ALTER TABLE [dbo].[CompanyDiscountMonthly] CHECK CONSTRAINT [CK_Parameters]
GO
