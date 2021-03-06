USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddCompanyReservationDetail]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCompanyReservationDetail]
	@ReservationID INT, 
	@TableID INT, 
	@ReservedFor INT,
	@People INT

AS
BEGIN
BEGIN try
	INSERT dbo.ReservationsCompanyDetails
	(
	    ReservationID,
	    TableID,
	    ReservedFor,
	    People
	)
	VALUES
	(   @ReservationID, -- ReservationID - int
	    @TableID, -- TableID - int
	    @ReservedFor, -- ReservedFor - int
	    @People  -- People - int
	    )
		
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot assing Reservations Detail . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
