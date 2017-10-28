 CREATE PROCEDURE EDOutbound_all
	@parm1 varchar( 3 )
AS
	SELECT *
	FROM EDOutbound
	WHERE ReleaseNbr LIKE @parm1
	ORDER BY ReleaseNbr


