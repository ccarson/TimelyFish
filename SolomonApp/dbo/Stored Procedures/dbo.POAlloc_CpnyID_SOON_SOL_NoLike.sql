 CREATE PROCEDURE POAlloc_CpnyID_SOON_SOL_NoLike
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 )
AS
	SELECT *
	FROM POAlloc (nolock)
	WHERE CpnyID = @parm1
	   AND SOOrdNbr = @parm2
	   AND SOLineRef = @parm3
	   AND SOSchedRef = @parm4
	ORDER BY CpnyID,
	   SOOrdNbr,
	   SOLineRef,
	   SOSchedRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POAlloc_CpnyID_SOON_SOL_NoLike] TO [MSDSL]
    AS [dbo];

