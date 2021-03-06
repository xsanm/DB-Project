USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddNewRecipe]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewRecipe]
	@IngredientID int,
	@ItemID int,
	@Amount int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM Ingredients
			WHERE IngredientID = @IngredientID
		)
		BEGIN
			; THROW 52000 , 'Ingredient does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM MenuItem
			WHERE ItemID = @ItemID
		)
		BEGIN
			; THROW 52000 , 'Menu Item does not exist .' ,1
		END

		IF @Amount < 0
		BEGIN
			; THROW 52000 , 'Amount can not be negative.' ,1
		END

		INSERT INTO Recipe(IngredientID, ItemID, Amount)
		VALUES (@IngredientID, @ItemID, @Amount)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot and new Recipe . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
