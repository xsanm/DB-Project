USE [u_kurowski]
GO
/****** Object:  Table [dbo].[ReservationsIndywidual]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationsIndywidual](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[TableID] [int] NOT NULL,
	[People] [int] NOT NULL,
	[IsAccepted] [bit] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReservationsIndywidual]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[ReservationsIndywidual] CHECK CONSTRAINT [FK_Reservations_Orders]
GO
ALTER TABLE [dbo].[ReservationsIndywidual]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndywidual_IndywidualCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[IndywidualCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[ReservationsIndywidual] CHECK CONSTRAINT [FK_ReservationsIndywidual_IndywidualCustomer]
GO
ALTER TABLE [dbo].[ReservationsIndywidual]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndywidual_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[ReservationsIndywidual] CHECK CONSTRAINT [FK_ReservationsIndywidual_Restaurants]
GO
ALTER TABLE [dbo].[ReservationsIndywidual]  WITH CHECK ADD  CONSTRAINT [FK_ReservationsIndywidual_Restrictions] FOREIGN KEY([TableID])
REFERENCES [dbo].[Restrictions] ([TableID])
GO
ALTER TABLE [dbo].[ReservationsIndywidual] CHECK CONSTRAINT [FK_ReservationsIndywidual_Restrictions]
GO
ALTER TABLE [dbo].[ReservationsIndywidual]  WITH CHECK ADD  CONSTRAINT [CK_ReservationsIndywidual] CHECK  (([StartTime]<=[EndTime]))
GO
ALTER TABLE [dbo].[ReservationsIndywidual] CHECK CONSTRAINT [CK_ReservationsIndywidual]
GO
