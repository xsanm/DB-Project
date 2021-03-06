USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[MenuInRestaurant]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MenuInRestaurant]
(
	@RestaurantID INT
)
RETURNS TABLE
AS
	RETURN
	(
		SELECT MenuItem.ItemID, dbo.MenuItem.Name, DateBegin, DateEnd
		FROM dbo.MenuItem
		INNER JOIN dbo.Menu
		ON Menu.ItemID = MenuItem.ItemID
		WHERE
		Menu.ResturantID = @RestaurantID AND
		DateEnd IS NULL
	)
GO
