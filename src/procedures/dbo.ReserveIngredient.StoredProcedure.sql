USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[ReserveIngredient]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReserveIngredient]
	@IngredientID int,
	@Value int
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


		IF @Value < 0
		BEGIN
			; THROW 52000 , 'VValue can not be negative.' ,1
		END

		UPDATE dbo.Ingredients
			SET UnitsReserved = UnitsReserved + @Value
			WHERE IngredientID = @IngredientID
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot Reserve Ingedient . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
