USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateInvoice]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateInvoice]
(
	@CustomerID INT,
	@RestaurantID INT
)
RETURNS @invoice TABLE
(
	param_name VARCHAR(50),
	param_val money
)
AS
	BEGIN
		DECLARE @RestaurantName VARCHAR(50)
		SET @RestaurantName = 
		(
			SELECT RestaurantName FROM dbo.Restaurants 
			WHERE RestaurantID = @RestaurantID
		)
		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   CONCAT('Restaurant Name: ', @RestaurantName),  -- param_name - varchar(50)
		    NULL -- param_val - money
		)

		DECLARE @CompanyName VARCHAR(50)
		SET @CompanyName = 
		(
			SELECT CompanyName FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   CONCAT('Company Name: ', @CompanyName),  -- param_name - varchar(50)
		    NULL -- param_val - money
		)

		DECLARE @NIP VARCHAR(50)
		SET @NIP = 
		(
			SELECT NIP FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   CONCAT('NIP: ', @NIP),  -- param_name - varchar(50)
		    NULL -- param_val - money
		)

		
		DECLARE @Adress VARCHAR(50)
		SET @Adress = 
		(
			SELECT Adress FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   CONCAT('Company Adress: ', @Adress),  -- param_name - varchar(50)
		    NULL -- param_val - money
		)

		
		DECLARE @Mail VARCHAR(50)
		SET @Mail = 
		(
			SELECT Email FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   CONCAT('email: ', @Mail),  -- param_name - varchar(50)
		    NULL -- param_val - money
		)

		
		DECLARE @OrdID INT
		DECLARE @Cost MONEY = 0

		DECLARE IT CURSOR FOR
		(
			SELECT OrderID FROM dbo.Orders
			WHERE CustomerID = @CustomerID AND 
			RestaurantID = @RestaurantID AND 
			DATEDIFF(DAY, OrderDate, GETDATE()) <= 31
		)
		
		OPEN IT
		FETCH NEXT FROM IT INTO @OrdID
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    INSERT @invoice
		    (
		        param_name,
		        param_val
		    )
		    VALUES
		    (   '',  -- param_name - varchar(50)
		        NULL -- param_val - money
		     )

			 INSERT @invoice
			 (
			     param_name,
			     param_val
			 )
			 VALUES
			 (   CONCAT('Order nr: ', @OrdID),  -- param_name - varchar(50)
			     NULL -- param_val - money
			 )

			 DECLARE @OrdDate DATE
			 SET @OrdDate = 
			 (
				SELECT OrderDate FROM dbo.Orders
				WHERE OrderID = @OrdID
			 )

			 INSERT @invoice
			 (
			     param_name,
			     param_val
			 )
			 VALUES
			 (   CONCAT('Order Date: ', @OrdDate),  -- param_name - varchar(50)
			     NULL -- param_val - money
			 )

			 DECLARE @Dish INT
			
			DECLARE DET CURSOR FOR 
            (
				SELECT ItemID FROM dbo.OrderDetails
				WHERE @OrdID = OrderID
			)

			OPEN DET
			FETCH NEXT FROM DET INTO @Dish
			WHILE @@FETCH_STATUS = 0
			BEGIN
				DECLARE @DishName VARCHAR(50)
				SET @DishName = 
				(
					SELECT Name FROM dbo.MenuItem
					WHERE dbo.MenuItem.ItemID = @Dish
				)

				DECLARE @Amount INT
				SET @Amount = 
				(
					SELECT Quantity FROM dbo.OrderDetails
					WHERE OrderID = @OrdID AND
					ItemID = @Dish
				)
				
				INSERT @invoice
				(
				    param_name,
				    param_val
				)
				VALUES
				(   CONCAT('Dish: ', @DishName, ', quantity: ', @Amount, ', cost: '),  -- param_name - varchar(50)
				    dbo.DishInOrderCost(@OrdID, @Dish) -- param_val - money
				  )


				FETCH NEXT FROM DET INTO @Dish
			END
			CLOSE DET
			DEALLOCATE DET

			INSERT @invoice
			(
			    param_name,
			    param_val
			)
			VALUES
			(   'Order Value',  -- param_name - varchar(50)
			    dbo.OrderCost(@OrdID) -- param_val - money
			 )
			 SET @Cost = @Cost + dbo.OrderCost(@OrdID)
			
			FETCH NEXT FROM IT INTO @OrdID
		END
		
		CLOSE IT
		DEALLOCATE IT

		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   '',  -- param_name - varchar(50)
		    NULL -- param_val - money
		    )

		INSERT @invoice
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Cost: ',  -- param_name - varchar(50)
		    @Cost -- param_val - money
		    )


		RETURN
	END



GO
