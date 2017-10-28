 CREATE PROCEDURE EDDMsg_SOType
		@DBName  varchar(30),	-- Database Name
		@SOType	 varchar(4)	-- SOType ID

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

	DECLARE @szSelect	varchar(500)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)

	SELECT @szSelect = "SELECT * FROM "

	SELECT @szFrom = @DBName + "..SOType"

	SELECT @szWhere = " WHERE SOTypeID = '" + @SOType + "'"
 

--PRINT (@szSelect + @szFrom + @szWhere) 
EXEC (@szSelect + @szFrom + @szWhere)

