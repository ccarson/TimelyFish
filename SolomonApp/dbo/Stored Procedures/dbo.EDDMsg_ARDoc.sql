 CREATE PROCEDURE EDDMsg_ARDoc
		@DBName  varchar(30),	-- Database Name
		@BatNbr varchar(10)		-- Batch Number

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

	DECLARE @szSelect	varchar(500)
	DECLARE @szFrom		varchar(500)
	DECLARE @szWhere	varchar(500)

	SELECT @szSelect = "SELECT * FROM "

	SELECT @szFrom = @DBName + "..ARDoc"

	SELECT @szWhere = " WHERE batnbr =  '" + @BatNbr + "'"
 

--PRINT (@szSelect + @szFrom + @szWhere) 
EXEC (@szSelect + @szFrom + @szWhere)

