USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddDishToOrder]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDishToOrder]
	@OrderID int,
	@ItemID int,
	@Quantity int
AS

BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM Orders
			WHERE Orders.OrderID = @OrderID
		)
		BEGIN
			; THROW 52000 , 'Order does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM Menu
			WHERE Menu.ItemID = @ItemID AND Menu.DateEnd is null
		)
		BEGIN
			; THROW 52000 , 'Menu Item does not exist .' ,1
		END

		
		DECLARE @NewUnits int
		DECLARE @UnitsToReserve int
		DECLARE @MyCursor CURSOR
		DECLARE @IngredientToRemove int
		BEGIN
           SET @MyCursor = CURSOR FOR
           SELECT IngredientID
           FROM DishRecipe(@ItemID)
          

           OPEN @MyCursor
           FETCH NEXT FROM @MyCursor
           INTO @IngredientToRemove

           WHILE @@FETCH_STATUS = 0
           BEGIN

               SELECT @UnitsToReserve = dbo.Recipe.Amount * @Quantity
               FROM dbo.Recipe
               WHERE dbo.Recipe.IngredientID = @IngredientToRemove AND dbo.Recipe.ItemID = @ItemID

			   PRINT(@IngredientToRemove)
			   PRINT(@UnitsToReserve)
               EXEC ReserveIngredient @IngredientToRemove, @UnitsToReserve


               FETCH NEXT FROM @MyCursor
               INTO @IngredientToRemove
           end

           CLOSE @MyCursor
           DEALLOCATE @MyCursor
       end
	   
		INSERT INTO OrderDetails(
			OrderID,
			ItemID,
			Quantity
			)
		VALUES (
			@OrderID,
			@ItemID,
			@Quantity
		)
        


	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add Order Details. Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
