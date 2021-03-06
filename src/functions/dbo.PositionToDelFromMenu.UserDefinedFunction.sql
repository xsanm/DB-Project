USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[PositionToDelFromMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[PositionToDelFromMenu]
(
	@RestaurantID INT,
	@DateOfMenuChange DATE
)
RETURNS TABLE
AS
	RETURN
	(
		SELECT DISTINCT A.ItemID, A.Name, MenuID
		FROM dbo.MenuItem AS A
		INNER JOIN dbo.Menu
		ON Menu.ItemID =A.ItemID
		WHERE 
		DateEnd IS NULL 
		AND DATEDIFF(WEEK, 
		(
			DateBegin
		), @DateOfMenuChange) >= 2
		AND @RestaurantID = dbo.Menu.ResturantID
	)
GO
