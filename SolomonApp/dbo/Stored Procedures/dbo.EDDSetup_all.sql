 CREATE PROCEDURE EDDSetup_all @parm1 varchar(10)
AS
	SELECT *
	FROM EDDSetup
	WHERE DocType LIKE @parm1
	ORDER BY DocType


