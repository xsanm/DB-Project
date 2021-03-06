USE [u_kurowski]
GO
/****** Object:  UserDefinedFunction [dbo].[DishRecipe]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DishRecipe]
(
	@ItemID int
)
RETURNS TABLE
AS
	RETURN
    (
		SELECT * FROM dbo.Recipe
		WHERE dbo.Recipe.ItemID = @ItemID
	)
GO
