USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[DelMenuItem]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DelMenuItem]
	@ItemID int
AS
BEGIN
	BEGIN TRY 
		IF NOT EXISTS
		(
			SELECT * FROM MenuItem
			WHERE MenuItem.ItemID = @ItemID
		)
		BEGIN
			; THROW 52000 , 'Item does not exist .' ,1
		END
		DELETE FROM MenuItem
			WHERE MenuItem.ItemID = @ItemID
	END TRY
	BEGIN CATCH
		DECLARE @errorMsg nvarchar (2048)
		= 'Cannot delete MenuItem . Error message : '
		+ ERROR_MESSAGE() ;
		; THROW 52000 , @errorMsg ,1;
	END CATCH
END
GO
