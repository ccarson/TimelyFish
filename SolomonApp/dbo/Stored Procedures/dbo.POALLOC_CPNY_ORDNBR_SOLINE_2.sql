 CREATE PROCEDURE POALLOC_CPNY_ORDNBR_SOLINE_2
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 )
AS
	SELECT *
	FROM POAlloc
	WHERE CpnyID = @parm1
	   AND SOOrdNbr = @parm2
	   AND SOLineRef LIKE @parm3
	   AND SOSchedRef LIKE @parm4
	ORDER BY SOLineRef,
	   SOSchedRef

GO
GRANT CONTROL
    ON OBJECT::[dbo].[POALLOC_CPNY_ORDNBR_SOLINE_2] TO [MSDSL]
    AS [dbo];

