USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddIndividualCustomerDiscount]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddIndividualCustomerDiscount]
	@CustomerID money,
	@DiscountID int,
	@BeginDate date,
	@EndDate date
AS
BEGIN
	BEGIN TRY 
		BEGIN
			; THROW 52000 , 'Restaurant does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM dbo.IndywidualCustomer
			WHERE IndywidualCustomer.CustomerID = @CustomerID
		)
		BEGIN
			; THROW 52000 , 'Customer does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM dbo.IndividualDiscountsOnce
			WHERE IndividualDiscountsOnce.DiscountID = @DiscountID
		)
		BEGIN
			; THROW 52000 , 'Discount does not exist .' ,1
		END
		IF NOT EXISTS
		(
			SELECT * FROM dbo.IndividualDiscountsConst
			WHERE IndividualDiscountsConst.DiscountID = @DiscountID
		)
		BEGIN
			; THROW 52000 , 'Discount does not exist .' ,1
		END
		
		INSERT INTO CompanyCustomerDiscount(
			CustomerID, 
			DiscountID,
			BeginDate,
			EndDate
			)
		VALUES (
			@CustomerID, 
			@DiscountID,
			@BeginDate,
			@EndDate
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
