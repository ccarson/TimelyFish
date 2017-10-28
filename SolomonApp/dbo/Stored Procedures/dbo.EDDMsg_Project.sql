 CREATE PROCEDURE EDDMsg_Project
		@DBName  varchar(30),	-- Database Name
		@project varchar(16)	-- Project ID

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

	DECLARE @szSelect	varchar(500)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)

	SELECT @szSelect = "SELECT * FROM "

	SELECT @szFrom = @DBName + "..pjproj"

	SELECT @szWhere = " WHERE project = '" + @project + "'"
 

--PRINT (@szSelect + @szFrom + @szWhere) 
EXEC (@szSelect + @szFrom + @szWhere)

