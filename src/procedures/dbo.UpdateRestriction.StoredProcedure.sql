USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[UpdateRestriction]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRestriction]
	@TableID int,
	@EndDate date,
	@BeginDate date,
	@PlacesAvailable int
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY 

		IF @TableID is null or NOT EXISTS
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

		IF @PlacesAvailable IS NOT NULL
		BEGIN
			IF @PlacesAvailable < 0 and 
				@PlacesAvailable < (SELECT Places from [Table] WHERE TableID = @TableID)
				BEGIN
					; THROW 52000 , 'Wrong places number.' ,1
				END
			UPDATE Restrictions
				SET PlacesAvailable = @PlacesAvailable
				WHERE Restrictions.TableID = @TableID
		END

		IF @EndDate IS NOT NULL
		BEGIN
			UPDATE Restrictions
				SET EndDate = @EndDate
				WHERE Restrictions.TableID = @TableID
		END

		IF @BeginDate IS NOT NULL
		BEGIN
			UPDATE Restrictions
				SET BeginDate = @BeginDate
				WHERE Restrictions.TableID = @TableID
		END
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot update Restrictions . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
