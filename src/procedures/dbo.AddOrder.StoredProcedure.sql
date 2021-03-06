USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddOrder]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrder]
	@CustomerID money,
	@OrderDate date,
	@RealizationDate datetime,
	@TypeID int,
	@PaymentType int,
	@PaymentDate date,
	@RestaurantID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM Restaurants
			WHERE Restaurants.RestaurantID = @RestaurantID
		)
		BEGIN
			; THROW 52000 , 'Restaurant does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM Customer
			WHERE Customer.CustomerID = @CustomerID
		)
		BEGIN
			; THROW 52000 , 'Customer does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM OrderType
			WHERE OrderType.TypeID = @TypeID
		)
		BEGIN
			; THROW 52000 , 'Order type does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM PaymentType
			WHERE PaymentType.TypeID = @PaymentType
		)
		BEGIN
			; THROW 52000 , 'Payment type does not exist .' ,1
		END
		
		INSERT INTO Orders(
			CustomerID,
			OrderDate,
			RealizationDate,
			Type,
			PaymentType,
			PaymentDate,
			RestaurantID
			)
		VALUES (
			@CustomerID,
			@OrderDate,
			@RealizationDate,
			@TypeID,
			@PaymentType,
			@PaymentDate,
			@RestaurantID
		)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add Order . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
