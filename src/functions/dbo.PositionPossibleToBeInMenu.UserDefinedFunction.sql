USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[PositionPossibleToBeInMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[PositionPossibleToBeInMenu]
(
	@RestaurantID INT,
	@DateOfMenuChange DATE
)
RETURNS TABLE
AS
	RETURN
	(
		SELECT DISTINCT A.ItemID, A.Name
		FROM dbo.MenuItem AS A
		INNER JOIN dbo.Menu AS B
		ON B.ItemID = A.ItemID
		WHERE 
		B.ResturantID = @RestaurantID AND
		NOT EXISTS
		(
			SELECT * FROM dbo.Menu
			WHERE dbo.Menu.ItemID = A.ItemID
			AND  dbo.Menu.ResturantID = @RestaurantID
			AND dbo.Menu.DateEnd IS NULL
		)
		AND DATEDIFF(MONTH, 
		 (
			SELECT TOP 1 DateEnd 
			FROM dbo.Menu
			WHERE Menu.ItemID = A.ItemID AND 
			Menu.ResturantID = @RestaurantID AND
			DateEnd IS NOT NULL
			ORDER BY DateEnd DESC
		), @DateOfMenuChange) >= 1
	)


	
GO
