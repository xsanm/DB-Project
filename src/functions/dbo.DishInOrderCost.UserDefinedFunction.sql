USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[DishInOrderCost]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DishInOrderCost]
(
	@OrderID INT,
	@ItemID INT
)
RETURNS MONEY
AS
BEGIN
RETURN
	(
		SELECT sum(MenuItem.Cost * OrderDetails.Quantity * 
		(1 - dbo.ActiveCustomerDiscountsValue(dbo.Orders.CustomerID, dbo.Orders.RestaurantID, @OrderID))) 
		FROM Orders
		INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
		INNER JOIN MenuItem ON OrderDetails.ItemID = MenuItem.ItemID
		WHERE Orders.OrderID = @OrderId AND MenuItem.ItemID = @ItemID
	)
END
GO
