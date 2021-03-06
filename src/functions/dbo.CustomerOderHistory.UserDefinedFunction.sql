USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[CustomerOderHistory]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CustomerOderHistory]
(
	@CustomerID int
)
RETURNS TABLE
AS
	RETURN
    (
		SELECT * FROM dbo.Orders
		WHERE dbo.Orders.CustomerID = @CustomerID
	)
GO
