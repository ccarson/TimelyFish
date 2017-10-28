 CREATE PROCEDURE POAlloc_Line
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 15 ),
        @parm5 varchar( 5 ),
        @parm6 varchar( 5 )
AS
	SELECT *
	FROM POAlloc
	WHERE CpnyID = @parm1
	   AND PONbr = @parm2
	   AND POLineRef = @parm3
           And SOOrdNbr = @Parm4
	   AND SOLineRef = @Parm5
           AND SOSchedRef = @Parm6


