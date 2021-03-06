USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddNewIngredient]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewIngredient]
	@Name varchar(50),
	@Unit varchar(50),
	@UnitsInStock int = 0,
	@UnitsReserved int = 0,
	@OnRequest bit = 0,
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

		IF @UnitsInStock < 0 OR  @UnitsInStock < 0
		BEGIN
			; THROW 52000 , 'Units number can not be negative.' ,1
		END

		INSERT INTO Ingredients(Name, Unit, UnitsInStock, UnitsReserved, OnRequest, ResturantID)
		VALUES (@Name, @Unit, @UnitsInStock, @UnitsReserved, @OnRequest, @RestaurantID)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot and new Ingredient . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
