USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[OrderCost]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[OrderCost]
(
	@OrderID INT
)
RETURNS MONEY
AS
BEGIN

RETURN
	(
		(SELECT sum(MenuItem.Cost * OrderDetails.Quantity  
		) 
		FROM Orders
		INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
		INNER JOIN MenuItem ON OrderDetails.ItemID = MenuItem.ItemID
		WHERE Orders.OrderID = @OrderId
		) * (1 - dbo.ActiveCustomerDiscountsValue(
		
		(SELECT CustomerID FROM dbo.Orders WHERE OrderID = @OrderID)
		, (SELECT RestaurantID FROM dbo.Orders WHERE OrderID = @OrderID)
		, @OrderID))

		
	)
END
GO
