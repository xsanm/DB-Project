USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddTable]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTable]
	@Places int,
	@ResturantID int
AS
BEGIN
	BEGIN TRY 
		--IF NOT EXISTS
		--(
		--	SELECT * FROM Restaurants
		--	WHERE RestaurantID = @ResturantID
		--)
		--BEGIN
		--	; THROW 52000 , 'Restaurant does not exist .' ,1
		--END

		IF @Places < 0
		BEGIN
			; THROW 52000 , 'Places number can not be negative.' ,1
		END

		INSERT INTO [Table](Places, ResturantID)
		VALUES (@Places, @ResturantID)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add new Table . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
