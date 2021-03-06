USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[TablesInRestaurant]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TablesInRestaurant]
(
	@RestaurantID int
)
RETURNS TABLE
AS
	RETURN
	(
		SELECT * FROM dbo.[Table]
		WHERE dbo.[Table].ResturantID = @RestaurantID
	)
GO
