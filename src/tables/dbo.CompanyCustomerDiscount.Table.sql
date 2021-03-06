USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CompanyCustomerDiscount]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyCustomerDiscount](
	[CustomerID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_CompanyCustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCustomerDiscount_CDiscounts] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[CDiscounts] ([DiscountID])
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount] CHECK CONSTRAINT [FK_CompanyCustomerDiscount_CDiscounts]
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCustomerDiscount_CompanyCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[CompanyCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount] CHECK CONSTRAINT [FK_CompanyCustomerDiscount_CompanyCustomer]
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [CK_Dates] CHECK  (([BeginDate]<=[EndDate]))
GO
ALTER TABLE [dbo].[CompanyCustomerDiscount] CHECK CONSTRAINT [CK_Dates]
GO
