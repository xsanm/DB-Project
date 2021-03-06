USE [u_kurowski]
GO
/****** Object:  Table [dbo].[ReservationsCompanyDetails]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsCompanyDetails](
	[ReservationID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[ReservedFor] [int] NOT NULL,
	[People] [int] NOT NULL,
 CONSTRAINT [PK_ReservationsCompantDetails_1] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC,
	[TableID] ASC,
	[ReservedFor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompantDetails_ReservationsCompany1] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[ReservationsCompany] ([ReservationID])
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails] CHECK CONSTRAINT [FK_ReservationsCompantDetails_ReservationsCompany1]
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompantDetails_Restrictions] FOREIGN KEY([TableID])
REFERENCES [dbo].[Restrictions] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails] CHECK CONSTRAINT [FK_ReservationsCompantDetails_Restrictions]
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsCompanyDetails_Customer] FOREIGN KEY([ReservedFor])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails] CHECK CONSTRAINT [FK_ReservationsCompanyDetails_Customer]
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsCompanyDetails] CHECK  (([People]>(0)))
GO
ALTER TABLE [dbo].[ReservationsCompanyDetails] CHECK CONSTRAINT [CK_ReservationsCompanyDetails]
GO
