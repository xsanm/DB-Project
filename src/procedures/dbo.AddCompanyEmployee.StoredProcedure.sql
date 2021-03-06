USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddCompanyEmployee]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCompanyEmployee]
	@CompanyID int,
	@EmployeeID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM CompanyCustomer
			WHERE CompanyCustomer.CustomerID = @CompanyID
		)
		BEGIN
			; THROW 52000 , 'Company does not exist .' ,1
		END

		IF NOT EXISTS
		(
			SELECT * FROM IndywidualCustomer
			WHERE IndywidualCustomer.CustomerID = @EmployeeID
		)
		BEGIN
			; THROW 52000 , 'Employee does not exist .' ,1
		END

		INSERT INTO CompanyEmployees(CompanyID, EmployeeID)
		VALUES (@CompanyID, @EmployeeID)
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot and Company Employee . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
