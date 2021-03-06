USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[ActiveCustomerDiscounts]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ActiveCustomerDiscounts]
(
	@CustomerID INT,
	@RestaurantID INT,
	@Date date
)
RETURNS TABLE
AS
	RETURN
    (
		SELECT dbo.IDiscount.DiscountID FROM dbo.IndividualCustomerDiscount
		INNER JOIN dbo.IDiscount ON IDiscount.DiscountID = IndividualCustomerDiscount.DiscountID
		WHERE 
		CustomerID = @CustomerID AND 
		RestaurantID = @RestaurantID AND
		IDiscount.BeginDate <= @Date AND 
		dbo.IDiscount.EndDate >= @Date AND
		IndividualCustomerDiscount.BeginDate <= @Date AND
		IndividualCustomerDiscount.EndDate >= @Date

		UNION

		SELECT dbo.CDiscounts.DiscountID FROM dbo.CompanyCustomerDiscount
		INNER JOIN dbo.CDiscounts ON CDiscounts.DiscountID = CompanyCustomerDiscount.DiscountID
		WHERE 
		CustomerID = @CustomerID AND 
		ResteurantID = @RestaurantID AND
		CDiscounts.BeginDate <=@Date AND 
		dbo.CDiscounts.EndDate >= @Date AND
		CompanyCustomerDiscount.BeginDate <= @Date AND
		CompanyCustomerDiscount.EndDate >= @Date
	)
GO
