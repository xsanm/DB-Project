USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddReservationForIndividual]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddReservationForIndividual]
	@CustomerID int,
	@OrderID int,
	@StartTime DATETIME,
	@EndTime DATETIME,
	@RestaurantID int,
	@TableID int,
	@People int,
	@IsAccepted bit
AS
BEGIN
	BEGIN TRY 
		INSERT dbo.ReservationsIndywidual
		(
		    CustomerID,
		    OrderID,
		    StartTime,
		    EndTime,
		    RestaurantID,
			TableID,
			People,
			IsAccepted
		)
		VALUES
		(   @CustomerID,
	@OrderID,
	@StartTime,
	@EndTime,
	@RestaurantID,
	@TableID,
	@People,
	@IsAccepted
		    )

		
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add new Reservation . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
