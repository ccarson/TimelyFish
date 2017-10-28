 CREATE PROCEDURE EDSetup_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM EDSetup
	WHERE SetUpID LIKE @parm1
	ORDER BY SetUpID


