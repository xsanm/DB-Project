USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddRestaurant]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddRestaurant]
	@RestaurantName varchar(50),
	@Adress varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Restaurants (RestaurantName, Adress)
	VALUES (@RestaurantName, @Adress)
END
GO
