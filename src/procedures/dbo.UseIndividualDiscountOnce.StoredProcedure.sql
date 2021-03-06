USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[UseIndividualDiscountOnce]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UseIndividualDiscountOnce]
	@CustomerID int,
	@DiscountID int
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY 

		IF @CustomerID IS NULL OR @DiscountID IS NULL
		BEGIN
			; THROW 52000 , 'Customer does not have this discount .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM dbo.IndividualCustomerDiscount
			WHERE @CustomerID = CustomerID
			AND @DiscountID = DiscountID
		)
		BEGIN
			; THROW 52000 , 'Customer does not have this discount .' ,1
		END
		UPDATE dbo.IndividualCustomerDiscount
			SET Used = 1
			WHERE @CustomerID = CustomerID
			AND @DiscountID = DiscountID


	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot use discount . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
