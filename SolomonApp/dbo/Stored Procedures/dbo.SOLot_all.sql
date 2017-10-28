 CREATE PROCEDURE SOLot_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 ),
	@parm5 varchar( 5 )
AS
	SELECT *
	FROM SOLot
	WHERE CpnyID = @parm1
	   AND OrdNbr = @parm2
	   AND LineRef LIKE @parm3
	   AND SchedRef LIKE @parm4
	   AND LotSerRef LIKE @parm5
	ORDER BY CpnyID,
	   OrdNbr,
	   LineRef,
	   SchedRef,
	   LotSerRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOLot_all] TO [MSDSL]
    AS [dbo];

