USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateReportForCompanyCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateReportForCompanyCustomer]
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
		DECLARE @CompanyName VARCHAR(50)
		SET @CompanyName = 
		(
			SELECT CompanyName FROM dbo.CompanyCustomer 
			WHERE CompanyCustomer.CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Customer Company name: ',  -- param_name - varchar(50)
		    @CompanyName -- param_val - money
		)
		
		DECLARE @NIP VARCHAR(50)
		SET @NIP = 
		(
			SELECT NIP FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'NIP: ',  -- param_name - varchar(50)
		    @NIP -- param_val - money
		)

		
		DECLARE @Adress VARCHAR(50)
		SET @Adress = 
		(
			SELECT Adress FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Company Adress: ',  -- param_name - varchar(50)
		    @Adress -- param_val - money
		)

		
		DECLARE @Mail VARCHAR(50)
		SET @Mail = 
		(
			SELECT Email FROM dbo.CompanyCustomer 
			WHERE CustomerID = @CustomerID
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'email: ',  -- param_name - varchar(50)
		    @Mail -- param_val - money
		)



		DECLARE @RestaurantsUSed int
		SET @RestaurantsUSed = 
		(
				SELECT COUNT(DISTINCT RestaurantID) FROM dbo.Orders
				INNER JOIN dbo.CompanyCustomer
				ON CompanyCustomer.CustomerID = Orders.CustomerID
				WHERE CompanyCustomer.CustomerID = @CustomerID AND
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
			SELECT COUNT(*) FROM dbo.ReservationsCompany
			WHERE dbo.ReservationsCompany.CompanyID = @CustomerID
			AND dbo.ReservationsCompany.StartTime BETWEEN @DateBegin AND @DateEnd
		
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
			(SELECT SUM(People) FROM dbo.ReservationsCompany
			INNER JOIN dbo.ReservationsCompanyDetails
			ON ReservationsCompanyDetails.ReservationID = ReservationsCompany.ReservationID
			WHERE dbo.ReservationsCompany.CompanyID = @CustomerID
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

		DECLARE @DiscountsAssignedNumber INT
        
		SET @DiscountsAssignedNumber = 
		(
			SELECT COUNT(*) FROM dbo.CompanyCustomerDiscount
			INNER JOIN dbo.CDiscounts 
			ON CDiscounts.DiscountID = CompanyCustomerDiscount.DiscountID
			WHERE dbo.CompanyCustomerDiscount.CustomerID = @CustomerID
			AND dbo.CDiscounts.BeginDate BETWEEN @DateBegin AND @DateEnd

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

		DECLARE @CompanyOrders int
		SET @CompanyOrders = 
		(
				SELECT COUNT(*) FROM dbo.Orders
				INNER JOIN dbo.CompanyCustomer
				ON CompanyCustomer.CustomerID = Orders.CustomerID
				WHERE CompanyCustomer.CustomerID = @CustomerID AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total number of orders: ',  -- param_name - varchar(50)
		    @CompanyOrders -- param_val - money
		)

		DECLARE @CompanyOrdersSUM MONEY
		SET @CompanyOrdersSUM = 
		(
				SELECT SUM(dbo.OrderCost(dbo.Orders.OrderID)) FROM dbo.Orders
				INNER JOIN dbo.CompanyCustomer
				ON CompanyCustomer.CustomerID = Orders.CustomerID
				WHERE CompanyCustomer.CustomerID = @CustomerID  AND
				dbo.Orders.OrderDate BETWEEN @DateBegin AND @DateEnd
		)
		INSERT @report
		(
		    param_name,
		    param_val
		)
		VALUES
		(   'Total orders cost sum:',  -- param_name - varchar(50)
		    CAST(@CompanyOrdersSUM AS VARCHAR(50))  -- param_val - money
		)


		RETURN
	END








GO
