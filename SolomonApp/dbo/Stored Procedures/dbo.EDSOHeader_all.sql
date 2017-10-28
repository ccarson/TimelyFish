 CREATE PROCEDURE EDSOHeader_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM EDSOHeader
	WHERE CpnyId LIKE @parm1
	   AND OrdNbr LIKE @parm2
	ORDER BY CpnyId,
	   OrdNbr


