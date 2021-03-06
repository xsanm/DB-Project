USE [u_kurowski]
GO
/****** Object:  Table [dbo].[ReservationsIndyvidualDetails]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsIndyvidualDetails](
	[ReservationID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[People] [int] NOT NULL,
 CONSTRAINT [PK_ReservationsDetails] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC,
	[TableID] ASC,
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsDetails_IndywidualCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[IndywidualCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails] CHECK CONSTRAINT [FK_ReservationsDetails_IndywidualCustomer]
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsDetails_Restrictions] FOREIGN KEY([TableID])
REFERENCES [dbo].[Restrictions] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails] CHECK CONSTRAINT [FK_ReservationsDetails_Restrictions]
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsIndyvidualDetails] CHECK  (([People]>(0)))
GO
ALTER TABLE [dbo].[ReservationsIndyvidualDetails] CHECK CONSTRAINT [CK_ReservationsIndyvidualDetails]
GO
