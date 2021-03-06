USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddNewMenuItem]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewMenuItem]
	@Name varchar(50),
	@Cost money,
	@CategotyID int,
	@RestaurantID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM Restaurants
			WHERE RestaurantID = @RestaurantID
		)
		BEGIN
			; THROW 52000 , 'Restaurant does not exist .' ,1
		END
		IF NOT EXISTS
		(
			SELECT * FROM Category
			WHERE CategoryID = @CategotyID
		)
		BEGIN
			; THROW 52000 , 'Category does not exist .' ,1
		END

		IF @Cost < 0 
		BEGIN
			; THROW 52000 , 'Cost can not be negative.' ,1
		END

		INSERT INTO MenuItem(Name, Cost, CategoryID, ResturantID)
		VALUES (@Name, @Cost, @CategotyID, @RestaurantID)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot and new MenuItem . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
