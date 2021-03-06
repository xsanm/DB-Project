USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[RemoveFromMenu]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveFromMenu]
	@MenuID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM dbo.Menu
			WHERE dbo.Menu.MenuID = @MenuID AND dbo.Menu.DateEnd IS NULL
		)
		BEGIN
			; THROW 52000 , 'MenuID does not exist or was removed.' ,1
		END


		UPDATE dbo.Menu
			SET DateEnd = GETDATE()
			WHERE Menu.MenuID = @MenuID
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Can not Remove Menu. Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
