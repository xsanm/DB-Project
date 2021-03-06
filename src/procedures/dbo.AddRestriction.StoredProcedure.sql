USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddRestriction]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRestriction]
	@TableID int,
	@EndDate date,
	@BeginDate date,
	@PlacesAvailable int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM [Table]
			WHERE [Table].TableID = @TableID
		)
		BEGIN
			; THROW 52000 , 'Table does not exist .' ,1
		END

		IF @PlacesAvailable < 0 and 
			@PlacesAvailable < (SELECT Places from [Table] WHERE TableID = @TableID)
		BEGIN
			; THROW 52000 , 'Wrong places number.' ,1
		END

		INSERT INTO Restrictions(TableID, EndDate, BeginDate, PlacesAvailable)
		VALUES (@TableID, @EndDate, @BeginDate, @PlacesAvailable)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add Restriction . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
