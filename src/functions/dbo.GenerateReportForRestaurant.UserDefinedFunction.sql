USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateReportForRestaurant]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateReportForRestaurant]
(
	@RestaurantID INT,
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
		DECLARE @RestaurantName VARCHAR(50)
		SET @RestaurantName = 
		(
			SELECT RestaurantName FROM dbo.Restaurants 
			WHERE RestaurantID = @RestaurantID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Restaurant Name: ',  -- param_name - varchar(50)
		    @RestaurantName -- param_val - money
		)

		DECLARE @Adress VARCHAR(50)
		SET @Adress = 
		(
			SELECT Adress FROM dbo.Restaurants 
			WHERE @RestaurantID = RestaurantID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Restaurant Addres: ', -- param_name - varchar(50)
		    @Adress  -- param_val - varchar(50)
		 )

		DECLARE @TablesNumber int
		SET @TablesNumber = 
		(
			SELECT COUNT(*) FROM dbo.[Table] 
			WHERE dbo.[Table].ResturantID = @RestaurantID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total tables Number: ',  -- param_name - varchar(50)
		    @TablesNumber -- param_val - money
		)

		DECLARE @PlacesNumber int
		SET @PlacesNumber = 
		(
			SELECT SUM(places) FROM dbo.[Table] 
			WHERE dbo.[Table].ResturantID = @RestaurantID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total place Number: ',  -- param_name - varchar(50)
		    @PlacesNumber -- param_val - money
		)

		DECLARE @ResevationNumber int
		SET @ResevationNumber = 
		(
			(
			SELECT COUNT(*) FROM dbo.ReservationsIndywidual
			WHERE dbo.ReservationsIndywidual.RestaurantID = @RestaurantID
			AND dbo.ReservationsIndywidual.StartTime BETWEEN @DateBegin AND @DateEnd
			)


			+
			(SELECT COUNT(*) FROM dbo.ReservationsCompany
			WHERE dbo.ReservationsCompany.RestaurantID = @RestaurantID
			AND dbo.ReservationsCompany.StartTime BETWEEN @DateBegin AND @DateEnd
			)

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
			WHERE dbo.ReservationsIndywidual.RestaurantID = @RestaurantID
			AND dbo.ReservationsIndywidual.StartTime BETWEEN @DateBegin AND @DateEnd
			)

			+
			(
			SELECT SUM(People) FROM dbo.ReservationsCompany
			INNER JOIN dbo.ReservationsCompanyDetails 
			ON ReservationsCompanyDetails.ReservationID = ReservationsCompany.ReservationID
			WHERE dbo.ReservationsCompany.RestaurantID = @RestaurantID
			AND dbo.ReservationsCompany.StartTime BETWEEN @DateBegin AND @DateEnd
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

		DECLARE @DiscountsNumber int
		SET @ReservedPlaces = 
		(
			(SELECT COUNT(*) FROM dbo.IDiscount
			WHERE dbo.IDiscount.RestaurantID = @RestaurantID
			AND dbo.IDiscount.BeginDate BETWEEN @DateBegin AND @DateEnd
			)
			+
			(
			SELECT  COUNT(*) FROM dbo.CDiscounts
			WHERE dbo.CDiscounts.ResteurantID = @RestaurantID AND
			dbo.CDiscounts.BeginDate BETWEEN @DateBegin AND @DateEnd
			)

		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total DiscountNumber: ',  -- param_name - varchar(50)
		    @ReservedPlaces -- param_val - money
		)

		DECLARE @DiscountsAssignedNumber int
		SET @DiscountsAssignedNumber = 
		(
			(SELECT COUNT(*) FROM dbo.IndividualCustomerDiscount
			INNER JOIN dbo.IDiscount 
			ON IDiscount.DiscountID = IndividualCustomerDiscount.DiscountID
			WHERE dbo.IDiscount.RestaurantID = @RestaurantID
			AND dbo.IDiscount.BeginDate BETWEEN @DateBegin AND @DateEnd
			)
			+
			(
			SELECT  COUNT(*) FROM dbo.CompanyCustomerDiscount
			INNER JOIN dbo.CDiscounts
			ON CDiscounts.DiscountID = CompanyCustomerDiscount.DiscountID
			WHERE dbo.CDiscounts.ResteurantID = @RestaurantID AND
			dbo.CDiscounts.BeginDate BETWEEN @DateBegin AND @DateEnd
			)

		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Discount Number assigned to customers: ',  -- param_name - varchar(50)
		    @DiscountsAssignedNumber -- param_val - money
		)

		DECLARE @DishesNumber int
		SET @DishesNumber = 
		(
				SELECT COUNT(DISTINCT ItemID) FROM dbo.Menu
				WHERE ResturantID = @RestaurantID AND
				dbo.Menu.DateBegin BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Number of Distinct Dishes in Menu: ',  -- param_name - varchar(50)
		    @DishesNumber -- param_val - money
		)

		DECLARE @IndividualOrders int
		SET @IndividualOrders = 
		(
				SELECT COUNT(*) FROM dbo.Orders
				INNER JOIN dbo.IndywidualCustomer
				ON IndywidualCustomer.CustomerID = Orders.CustomerID
				WHERE RestaurantID = @RestaurantID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Number orders made by individual Customers: ',  -- param_name - varchar(50)
		    @IndividualOrders -- param_val - money
		)

		DECLARE @IndividualOrdersSUM MONEY
		SET @IndividualOrdersSUM = 
		(
				SELECT SUM(dbo.OrderCost(dbo.Orders.OrderID)) FROM dbo.Orders
				INNER JOIN dbo.IndywidualCustomer
				ON IndywidualCustomer.CustomerID = Orders.CustomerID
				WHERE RestaurantID = @RestaurantID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total orders cost sum made by individual:',  -- param_name - varchar(50)
		    CAST(@IndividualOrdersSUM AS VARCHAR(50))  -- param_val - money
		)

		DECLARE @CompanyOrders int
		SET @CompanyOrders = 
		(
				SELECT COUNT(*) FROM dbo.Orders
				INNER JOIN dbo.CompanyCustomer
				ON CompanyCustomer.CustomerID = Orders.CustomerID
				WHERE RestaurantID = @RestaurantID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total Number orders made by Compoany Customers: ',  -- param_name - varchar(50)
		    @CompanyOrders -- param_val - money
		)

		DECLARE @CompanyOrdersSUM MONEY
		SET @CompanyOrdersSUM = 
		(
				SELECT SUM(dbo.OrderCost(dbo.Orders.OrderID)) FROM dbo.Orders
				INNER JOIN dbo.CompanyCustomer
				ON CompanyCustomer.CustomerID = Orders.CustomerID
				WHERE RestaurantID = @RestaurantID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total orders cost sum made by company:',  -- param_name - varchar(50)
		    CAST(@CompanyOrdersSUM AS VARCHAR(50))  -- param_val - money
		)

		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total orders cost sum', -- param_name - varchar(50)
		     CAST(ROUND(@IndividualOrdersSUM + @CompanyOrdersSUM, 2) AS VARCHAR(50))  -- param_val - varchar(50)
		 )


		
		RETURN
	END




GO
