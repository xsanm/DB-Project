USE [u_kurowski]
GO
/****** Object:  Table [dbo].[IndividualCustomerDiscount]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndividualCustomerDiscount](
	[CustomerID] [int] NOT NULL,
	[DiscountID] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Used] [int] NULL,
 CONSTRAINT [PK_IndividualCustomerDiscount_1] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_IndividualCustomerDiscount_IDiscount1] FOREIGN KEY([DiscountID])
REFERENCES [dbo].[IDiscount] ([DiscountID])
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount] CHECK CONSTRAINT [FK_IndividualCustomerDiscount_IDiscount1]
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_IndividualCustomerDiscount_IndywidualCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[IndywidualCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount] CHECK CONSTRAINT [FK_IndividualCustomerDiscount_IndywidualCustomer]
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [CK_IndividualCustomerDiscount_Date] CHECK  (([BeginDate]<=[EndDate]))
GO
ALTER TABLE [dbo].[IndividualCustomerDiscount] CHECK CONSTRAINT [CK_IndividualCustomerDiscount_Date]
GO
