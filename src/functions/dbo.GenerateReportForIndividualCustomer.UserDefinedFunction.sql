USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateReportForIndividualCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateReportForIndividualCustomer]
(
	@CustomerID INT,
	@DateBegin DATE,
	@DateEnd DATE
)
RETURNS @report TABLE
(
	param_name VARCHAR(50),
	param_val VARCHAR(50)
)
AS
	BEGIN
		DECLARE @CustomerFirstName VARCHAR(50)
		SET @CustomerFirstName = 
		(
			SELECT FirstName FROM dbo.IndywidualCustomer 
			WHERE IndywidualCustomer.CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Customer First Name: ',  -- param_name - varchar(50)
		    @CustomerFirstName -- param_val - money
		)

		DECLARE @CustomerLastName VARCHAR(50)
		SET @CustomerLastName = 
		(
			SELECT LastName FROM dbo.IndywidualCustomer 
			WHERE IndywidualCustomer.CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Customer Last Name: ',  -- param_name - varchar(50)
		    @CustomerLastName -- param_val - money
		)

		DECLARE @RestaurantsUSed int
		SET @RestaurantsUSed = 
		(
				SELECT COUNT(DISTINCT RestaurantID) FROM dbo.Orders
				INNER JOIN dbo.IndywidualCustomer
				ON IndywidualCustomer.CustomerID = Orders.CustomerID
				WHERE IndywidualCustomer.CustomerID = @CustomerID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Number of choosed restaurants: ',  -- param_name - varchar(50)
		    @RestaurantsUSed -- param_val - money
		)

		DECLARE @ResevationNumber int
		SET @ResevationNumber = 
		(
			SELECT COUNT(*) FROM dbo.ReservationsIndywidual
			WHERE dbo.ReservationsIndywidual.CustomerID = @CustomerID
			AND dbo.ReservationsIndywidual.StartTime BETWEEN @DateBegin AND @DateEnd
		
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Reservation Number: ',  -- param_name - varchar(50)
		    @ResevationNumber -- param_val - money
		)

		DECLARE @ReservedPlaces int
		SET @ReservedPlaces = 
		(
			(SELECT SUM(People) FROM dbo.ReservationsIndywidual
			WHERE dbo.ReservationsIndywidual.CustomerID = @CustomerID
			AND dbo.ReservationsIndywidual.StartTime BETWEEN @DateBegin AND @DateEnd
			)

		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Reserved Places: ',  -- param_name - varchar(50)
		    @ReservedPlaces -- param_val - money
		)

		DECLARE @DiscountsAssignedNumber INT
        
		SET @DiscountsAssignedNumber = 
		(
			SELECT COUNT(*) FROM dbo.IndividualCustomerDiscount
			INNER JOIN dbo.IDiscount 
			ON IDiscount.DiscountID = IndividualCustomerDiscount.DiscountID
			WHERE dbo.IndividualCustomerDiscount.CustomerID = @CustomerID
			AND dbo.IDiscount.BeginDate BETWEEN @DateBegin AND @DateEnd

		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Discount assigned: ',  -- param_name - varchar(50)
		    @DiscountsAssignedNumber -- param_val - money
		)

		DECLARE @IndividualOrders int
		SET @IndividualOrders = 
		(
				SELECT COUNT(*) FROM dbo.Orders
				INNER JOIN dbo.IndywidualCustomer
				ON IndywidualCustomer.CustomerID = Orders.CustomerID
				WHERE IndywidualCustomer.CustomerID = @CustomerID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total number of orders: ',  -- param_name - varchar(50)
		    @IndividualOrders -- param_val - money
		)

		DECLARE @IndividualOrdersSUM MONEY
		SET @IndividualOrdersSUM = 
		(
				SELECT SUM(dbo.OrderCost(dbo.Orders.OrderID)) FROM dbo.Orders
				INNER JOIN dbo.IndywidualCustomer
				ON IndywidualCustomer.CustomerID = Orders.CustomerID
				WHERE IndywidualCustomer.CustomerID = @CustomerID  AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total orders cost sum:',  -- param_name - varchar(50)
		    CAST(@IndividualOrdersSUM AS VARCHAR(50))  -- param_val - money
		)


		RETURN
	END




GO
