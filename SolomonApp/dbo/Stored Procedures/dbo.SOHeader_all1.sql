 CREATE PROCEDURE SOHeader_all1
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SOHeader
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	ORDER BY CpnyID,
	   OrdNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_all1] TO [MSDSL]
    AS [dbo];

