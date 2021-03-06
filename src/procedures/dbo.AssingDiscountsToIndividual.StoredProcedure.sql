USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AssingDiscountsToIndividual]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssingDiscountsToIndividual]
	@OrderID INT --order after which we counting discounts
AS
BEGIN
	BEGIN TRY
	DECLARE @RestaurantID INT = (
		SELECT RestaurantID FROM dbo.Orders
		WHERE @OrderID = OrderID
	)

	DECLARE @CustomerID INT = (
		SELECT CustomerID FROM dbo.Orders
		WHERE @OrderID = OrderID
	)

	DECLARE @PDate date = (
		SELECT PaymentDate FROM dbo.Orders
		WHERE @OrderID = OrderID
	)

	DECLARE @DiscountsAvailable TABLE
	(
		DiscountID int
	)

	INSERT INTO @DiscountsAvailable
	(
	    DiscountID
	)
	VALUES
	(
		(
			SELECT DiscountID FROM dbo.IDiscount
			WHERE @RestaurantID = RestaurantID AND
			@PDate BETWEEN BeginDate AND EndDate
		)
	)

	DECLARE @CurrentDiscount INT

	DECLARE DISC CURSOR FOR 
	(
		SELECT * FROM @DiscountsAvailable
	)

	OPEN DISC
	FETCH NEXT FROM DISC INTO @CurrentDiscount
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS
		(
			SELECT * FROM dbo.IndividualCustomerDiscount
			WHERE DiscountID = @CurrentDiscount AND 
			@PDate BETWEEN BeginDate AND EndDate
		)
		BEGIN
			IF EXISTS --znika jednorazowa
			(
				SELECT * FROM dbo.IndividualDiscountsConst
				WHERE DiscountID = @CurrentDiscount
			)
			BEGIN
				IF 
				(
					SELECT COUNT(*) FROM dbo.Orders
					WHERE dbo.Orders.CustomerID = @CustomerID AND
					dbo.Orders.PaymentDate >= 
					(
						SELECT BeginDate FROM dbo.IDiscount
						WHERE dbo.IDiscount.DiscountID = @CurrentDiscount
					) AND 
					RestaurantID = @RestaurantID
					AND
					dbo.OrderCost(OrderID) >=
					(
						SELECT K1 FROM dbo.IndividualDiscountsConst
						WHERE dbo.IndividualDiscountsConst.DiscountID = @CurrentDiscount
					)
				) >= 
				(
					SELECT Z1 FROM dbo.IndividualDiscountsConst
					WHERE dbo.IndividualDiscountsConst.DiscountID = @CurrentDiscount
				)
				BEGIN
					INSERT dbo.IndividualCustomerDiscount
					(
					    CustomerID,
					    DiscountID,
					    BeginDate,
					    EndDate,
					    Used
					)
					VALUES
					(   @CustomerID,         -- CustomerID - int
					    @CurrentDiscount,         -- DiscountID - int
					    @PDate, -- BeginDate - date
						(
							SELECT EndDate FROM dbo.IDiscount
							WHERE dbo.IDiscount.DiscountID = @CurrentDiscount
						), -- EndDate - date
					    NULL       -- Used - bit
					    )
				END
			END

			IF EXISTS --znika ciagla
			(
				SELECT * FROM dbo.IndividualDiscountsOnce
				WHERE DiscountID = @CurrentDiscount
			)
			BEGIN
				IF 
				(
					SELECT SUM(dbo.OrderCost(OrderID)) FROM dbo.Orders
					WHERE dbo.Orders.CustomerID = @CustomerID AND
					dbo.Orders.PaymentDate >= 
					(
						SELECT BeginDate FROM dbo.IDiscount
						WHERE dbo.IDiscount.DiscountID = @CurrentDiscount
					) AND 
					RestaurantID = @RestaurantID
				) >= 
				(
					SELECT K2 FROM dbo.IndividualDiscountsOnce
					WHERE dbo.IndividualDiscountsOnce.DiscountID = @CurrentDiscount
				)
				BEGIN
					INSERT dbo.IndividualCustomerDiscount
					(
					    CustomerID,
					    DiscountID,
					    BeginDate,
					    EndDate,
					    Used
					)
					VALUES
					(   @CustomerID,         -- CustomerID - int
					    @CurrentDiscount,         -- DiscountID - int
					    @PDate, -- BeginDate - date
					    DATEADD(DAY,
						(
							SELECT D1 FROM dbo.IndividualDiscountsOnce
							WHERE dbo.IndividualDiscountsOnce.DiscountID = @CurrentDiscount
						)
						, @PDate), -- EndDate - date
					    NULL       -- Used - bit
					    )
				END
			END
		END


		FETCH NEXT FROM DISC INTO @CurrentDiscount
	END

	CLOSE DISC
	DEALLOCATE DISC
	
	
		
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot assing Discounts . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
