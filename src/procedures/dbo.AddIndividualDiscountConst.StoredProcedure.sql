USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddIndividualDiscountConst]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddIndividualDiscountConst]
	@Z1 int,
	@K1 money,
	@R1 float,
	@BeginDate date,
	@EndDate date,
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

		INSERT INTO dbo.IDiscount
		(
		    BeginDate,
		    EndDate,
		    RestaurantID
		)
		VALUES
		(   @BeginDate,
		    @EndDate,
		    @RestaurantID 
		)

		DECLARE @DiscountID int;
		SELECT @DiscountID = scope_identity();

		INSERT INTO dbo.IndividualDiscountsConst
		(
		    DiscountID,
		    Z1,
		    K1,
		    R1
		)
		VALUES
		(   @DiscountID,  
		    @Z1,
		    @K1,
		    @R1
		)

	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add Discount . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
