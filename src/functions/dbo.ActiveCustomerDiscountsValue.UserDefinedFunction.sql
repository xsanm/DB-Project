USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[ActiveCustomerDiscountsValue]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ActiveCustomerDiscountsValue]
(
	@CustomerID INT,
	@RestaurantID INT,
	@OrderID INT
)
RETURNS FLOAT
AS
	BEGIN
		DECLARE @discount FLOAT
		DECLARE @allD TABLE
		(
			DiscountID int
		)

		INSERT INTO @allD (DiscountID)
		(SELECT * FROM  dbo.ActiveCustomerDiscounts(@CustomerID, @RestaurantID, 
		(
			SELECT PaymentDate FROM Orders
			WHERE OrderID = @OrderID
		)		
		))

		
		SET @discount = 0
		
		IF EXISTS --individual customer
		(
			SELECT * FROM dbo.IndywidualCustomer 
			WHERE CustomerID = @CustomerID
		)
		BEGIN
			SET @discount = @discount + ISNULL(
			(
				SELECT SUM(R1) FROM @allD
				INNER JOIN dbo.IndividualDiscountsConst 
				ON IndividualDiscountsConst.DiscountID = [@allD].DiscountID
			), 0)
			SET @discount = @discount + ISNULL(
			(
				SELECT SUM(R2) FROM @allD
				INNER JOIN dbo.IndividualDiscountsOnce 
				ON IndividualDiscountsOnce.DiscountID = [@allD].DiscountID

			), 0)
		END
		ELSE
		BEGIN

			DECLARE @MonthDiscountID INT = 
			(
				SELECT  [@allD].DiscountID FROM @allD
				INNER JOIN dbo.CompanyDiscountMonthly
				ON CompanyDiscountMonthly.DiscountID = [@allD].DiscountID
				WHERE [@allD].DiscountID IS NOT NULL
			)
			DECLARE @QuarterDiscountID INT = 
			(
				SELECT  [@allD].DiscountID FROM @allD
				INNER JOIN dbo.CompanyDiscountQuarter
				ON CompanyDiscountQuarter.DiscountID = [@allD].DiscountID
				WHERE [@allD].DiscountID IS NOT NULL
			)

			DECLARE @MonthDiscountValue FLOAT = ISNULL(
			(
				DATEDIFF(MONTH, 
						(
							SELECT BeginDate FROM dbo.CompanyCustomerDiscount
							WHERE CustomerID = @CustomerID 
							AND DiscountID = @MonthDiscountID
						), 
						(
							SELECT PaymentDate FROM dbo.Orders
							WHERE @OrderID = OrderID

						)) * 
						(
							SELECT FR1 FROM dbo.CompanyDiscountMonthly
							WHERE DiscountID = @MonthDiscountID
						)
			), 0)

			DECLARE @QuarterDiscountValue FLOAT = ISNULL(
			(
				DATEDIFF(QUARTER, 
						(
							SELECT BeginDate FROM dbo.CompanyCustomerDiscount
							WHERE CustomerID = @CustomerID 
							AND DiscountID = @MonthDiscountID
						), 
						(
							SELECT PaymentDate FROM dbo.Orders
							WHERE @OrderID = OrderID

						)) * 
						(
							SELECT FR2 FROM dbo.CompanyDiscountQuarter
							WHERE DiscountID = @MonthDiscountID
						)
			), 0)

			SET @discount = @QuarterDiscountValue
			IF @MonthDiscountValue <= 
			ISNULL((
				SELECT FM FROM dbo.CompanyDiscountMonthly
				WHERE DiscountID = @MonthDiscountID
			), 0)
			BEGIN
				SET @discount = @discount + @MonthDiscountValue
			END
			ELSE
			BEGIN
				SET @discount = @discount +
				ISNULL((
					SELECT FM FROM dbo.CompanyDiscountMonthly
					WHERE DiscountID = @MonthDiscountID
				), 0)
			END


		END

		RETURN @discount
	END
GO
