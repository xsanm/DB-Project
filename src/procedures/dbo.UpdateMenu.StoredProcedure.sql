USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[UpdateMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMenu]
	@MenuID int,
	@DateEnd date
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY 

		IF NOT EXISTS
		(
			SELECT * FROM Menu
			WHERE Menu.MenuID = @MenuID
		)
		BEGIN
			; THROW 52000 , 'Menu does not exist .' ,1
		END


		IF @DateEnd IS NOT NULL
		BEGIN
			UPDATE Menu
				SET DateEnd = @DateEnd
				WHERE Menu.MenuID = @MenuID
		END
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot update Manu . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
