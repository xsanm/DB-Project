USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddToMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddToMenu]
	@ItemID int,
	@DateBegin date = null,
	@DateEnd date = null,
	@ResturantID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM MenuItem
			WHERE MenuItem.ItemID = @ItemID
		)
		BEGIN
			; THROW 52000 , 'Menu Item does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM Restaurants
			WHERE Restaurants.RestaurantID = @ResturantID
		)
		BEGIN
			; THROW 52000 , 'Restaurant does not exist .' ,1
		END

		IF @DateBegin is null
		BEGIN
			SET @DateBegin = getdate()
		END

		INSERT INTO Menu(ItemID, DateBegin, DateEnd, ResturantID)
		VALUES (@ItemID, @DateBegin, @DateEnd, @ResturantID)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add item to the menu. Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
