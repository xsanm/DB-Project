USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AssingDiscountsToCompany]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssingDiscountsToCompany]
	@OrderID INT --order after which we counting discounts
AS
BEGIN
	BEGIN TRY
	DECLARE @RestaurantID INT = (
		SELECT RestaurantID FROM dbo.Orders
		WHERE @OrderID = dbo.Orders.OrderID
	)

	DECLARE @CustomerID INT = (
		SELECT CustomerID FROM dbo.Orders
		WHERE @OrderID = dbo.Orders.OrderID
	)

	DECLARE @PDate date = (
		SELECT PaymentDate FROM dbo.Orders
		WHERE @OrderID =dbo.Orders.OrderID
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
			SELECT DiscountID FROM dbo.CDiscounts
			WHERE @RestaurantID = ResteurantID AND
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

		IF @CurrentDiscount IS NOT NULL
		BEGIN
		IF EXISTS
		(
			SELECT * FROM dbo.CompanyCustomerDiscount
			WHERE DiscountID = @CurrentDiscount AND 
			@PDate BETWEEN BeginDate AND EndDate
		)
		BEGIN
			IF EXISTS --znika miesieczna
			(
				SELECT * FROM dbo.CompanyDiscountMonthly
				WHERE DiscountID = @CurrentDiscount
			)
			BEGIN
				IF 
				(
					SELECT COUNT(*) FROM dbo.Orders
					WHERE dbo.Orders.CustomerID = @CustomerID AND
					dbo.Orders.PaymentDate >= 
					(
						SELECT TOP 1 BeginDate FROM dbo.CDiscounts
						WHERE dbo.CDiscounts.DiscountID = @CurrentDiscount
					) AND 
					RestaurantID = @RestaurantID
					AND
					dbo.OrderCost(OrderID) >=
					(
						SELECT TOP 1 FK1 FROM dbo.CompanyDiscountMonthly
						WHERE dbo.CompanyDiscountMonthly.DiscountID = @CurrentDiscount
					) AND
					DATEDIFF(MONTH, dbo.Orders.PaymentDate, @PDate) <= 1
				) < 
				(
					SELECT TOP 1 FZ FROM dbo.CompanyDiscountMonthly
					WHERE dbo.CompanyDiscountMonthly.DiscountID = @CurrentDiscount
				) 
				BEGIN
					UPDATE dbo.CompanyCustomerDiscount
					SET BeginDate = @PDate
					WHERE DiscountID = @CurrentDiscount AND
					CustomerID = @CustomerID
				END
			END

			IF EXISTS --znika kwartalne
			(
				SELECT * FROM dbo.CompanyDiscountQuarter
				WHERE DiscountID = @CurrentDiscount
			)
			BEGIN
				IF 
				(
					SELECT SUM(dbo.OrderCost(OrderID)) FROM dbo.Orders
					WHERE dbo.Orders.CustomerID = @CustomerID AND
					dbo.Orders.PaymentDate >= 
					(
						SELECT TOP 1 BeginDate FROM dbo.CDiscounts
						WHERE dbo.CDiscounts.DiscountID = @CurrentDiscount
					) AND RestaurantID = @RestaurantID AND
					DATEDIFF(QUARTER, dbo.Orders.PaymentDate, @PDate) <= 1
				) >= 
				(
					SELECT TOP 1 FK2 FROM dbo.CompanyDiscountQuarter
					WHERE dbo.CompanyDiscountQuarter.DiscountID = @CurrentDiscount
				)
				BEGIN
					UPDATE dbo.CompanyCustomerDiscount
					SET BeginDate = @PDate
					WHERE DiscountID = @CurrentDiscount AND
					CustomerID = @CustomerID
				END
			END
		END
		ELSE
		BEGIN
			INSERT dbo.CompanyCustomerDiscount
			(
			    CustomerID,
			    DiscountID,
			    BeginDate,
			    EndDate
			)
			VALUES
			(   @CustomerID,         -- CustomerID - int
			    @CurrentDiscount,         -- DiscountID - int
			    @PDate, -- BeginDate - date
			    (
					SELECT TOP 1 EndDate FROM dbo.CDiscounts
					WHERE DiscountID = @CurrentDiscount
				)  -- EndDate - date
			    )
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
