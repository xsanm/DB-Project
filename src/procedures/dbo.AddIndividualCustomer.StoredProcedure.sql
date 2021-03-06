USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddIndividualCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddIndividualCustomer]
	@FirstName varchar(50),
	@LastName varchar(50),
	@PhoneNumber varchar(50)
AS
BEGIN

	DECLARE @CustomerID int;
	BEGIN TRY 
		INSERT INTO Customer(PhoneNumber)
		VALUES (@PhoneNumber)


		SELECT @CustomerID = scope_identity();
		INSERT INTO IndywidualCustomer(CustomerID, FirstName, LastName)
		VALUES (@CustomerID, @FirstName, @LastName)

	END TRY
	BEGIN CATCH
		DELETE FROM Customer
			WHERE Customer.CustomerID = @CustomerID
			
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add new Individual Customer . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
