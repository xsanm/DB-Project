USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddCompanyCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCompanyCustomer]
	@CompanyName varchar(50),
	@NIP varchar(50),
	@Adress varchar(50),
	@Email varchar(50),
	@PhoneNumber varchar(50)
AS
BEGIN
	BEGIN TRY 
		INSERT INTO Customer(PhoneNumber)
		VALUES (@PhoneNumber)

		DECLARE @CustomerID int;
		SELECT @CustomerID = scope_identity();
		INSERT INTO CompanyCustomer(CustomerID, CompanyName, NIP, Adress, Email)
		VALUES (@CustomerID, @CompanyName, @NIP, @Adress, @Email)

	END TRY
	BEGIN CATCH
		DELETE FROM Customer
			WHERE Customer.CustomerID = @CustomerID
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot add new Company Customer . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
