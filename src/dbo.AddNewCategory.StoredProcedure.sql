USE [u_kurowski]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCategory]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewCategory]
	@CategoryName varchar(60)
AS
BEGIN
	INSERT INTO Category (CategoryName)
	VALUES (@CategoryName)
END
GO
