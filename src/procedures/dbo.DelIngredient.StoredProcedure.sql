USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[DelIngredient]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DelIngredient]
	@IngredientID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM Ingredients
			WHERE Ingredients.IngredientID = @IngredientID
		)
		BEGIN
			; THROW 52000 , 'Ingredient does not exist .' ,1
		END
		DELETE FROM Ingredients
			WHERE Ingredients.IngredientID = @IngredientID
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot delete Ingredient . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
