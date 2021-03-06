USE [u_kurowski]
GO
/****** Object:  Table [dbo].[ReservationsCompany]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsCompany](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[ReservationType] [int] NOT NULL,
 CONSTRAINT [PK_ReservationsCompany_1] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReservationsCompany]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompany_CompanyCustomer] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[CompanyCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsCompany] CHECK CONSTRAINT [FK_ReservationsCompany_CompanyCustomer]
GO
ALTER TABLE [dbo].[ReservationsCompany]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompany_ReservationType] FOREIGN KEY([ReservationType])
REFERENCES [dbo].[ReservationType] ([TypeID])
GO
ALTER TABLE [dbo].[ReservationsCompany] CHECK CONSTRAINT [FK_ReservationsCompany_ReservationType]
GO
ALTER TABLE [dbo].[ReservationsCompany]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompany_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[ReservationsCompany] CHECK CONSTRAINT [FK_ReservationsCompany_Restaurants]
GO
ALTER TABLE [dbo].[ReservationsCompany]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsCompany] CHECK  (([StartTime]<=[EndTime]))
GO
ALTER TABLE [dbo].[ReservationsCompany] CHECK CONSTRAINT [CK_ReservationsCompany]
GO
