USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[UpdateIngredient]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIngredient]
	@IngredientID int,
	@Name varchar(50),
	@Unit varchar(50),
	@UnitsInStock int,
	@UnitsReserved int,
	@OnRequest bit
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY 


		IF NOT EXISTS
		(
			SELECT * FROM Ingredients
			WHERE IngredientID = @IngredientID
		)
		BEGIN
			; THROW 52000 , 'Ingredient does not exist .' ,1
		END

		IF @UnitsInStock < 0 OR  @UnitsInStock < 0
		BEGIN
			; THROW 52000 , 'Units number can not be negative.' ,1
		END

		IF @UnitsInStock IS NOT NULL
		BEGIN
			UPDATE Ingredients
				SET UnitsInStock = @UnitsInStock
				WHERE Ingredients.IngredientID = @IngredientID
		END

		IF @UnitsReserved IS NOT NULL
		BEGIN
			UPDATE Ingredients
				SET UnitsReserved = @UnitsReserved
				WHERE Ingredients.IngredientID = @IngredientID
		END

		IF @OnRequest IS NOT NULL
		BEGIN
			UPDATE Ingredients
				SET OnRequest = @OnRequest
				WHERE Ingredients.IngredientID = @IngredientID
		END
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot update Ingredient . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
