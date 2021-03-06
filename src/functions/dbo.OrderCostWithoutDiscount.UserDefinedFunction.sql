USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[OrderCostWithoutDiscount]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[OrderCostWithoutDiscount]
	(
		@OrderId int
	) 
	RETURNS money
AS
BEGIN
	RETURN
	(
		SELECT sum(MenuItem.Cost * OrderDetails.Quantity) 
		FROM Orders
		INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
		INNER JOIN MenuItem ON OrderDetails.ItemID = MenuItem.ItemID
		WHERE Orders.OrderID = @OrderId
	)
END
GO
