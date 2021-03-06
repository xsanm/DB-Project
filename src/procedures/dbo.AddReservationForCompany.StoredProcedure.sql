USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddReservationForCompany]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddReservationForCompany]
	@CompanyID int,
	@StartTime datetime,
	@EndTime datetime,
	@RestaurantID int,
	@ReservationType varchar(50)
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM dbo.Restaurants
			WHERE RestaurantID = @RestaurantID
		)
		BEGIN
			; THROW 52000 , 'Restaurant does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM ReservationType
			WHERE ReservationType.TypeID = @ReservationType
		)
		BEGIN
			; THROW 52000 , 'Reservation Type does not exist .' ,1
		END

		INSERT INTO dbo.ReservationsCompany
		(
		    CompanyID,
		    StartTime,
		    EndTime,
		    RestaurantID,
			ReservationType  
		)
		VALUES
		(   @CompanyID,         -- ReservationID - int
		    @StartTime,         -- CompanyID - int
		    @EndTime, -- EndTime - datetime
		    @RestaurantID, -- StartTime - datetime
		    @ReservationType         -- RestaurantID - int
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
