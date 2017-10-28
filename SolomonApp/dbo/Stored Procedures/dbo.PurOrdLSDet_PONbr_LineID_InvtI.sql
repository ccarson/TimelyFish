 CREATE PROCEDURE PurOrdLSDet_PONbr_LineID_InvtI
	@parm1 varchar( 10 ),
	@parm2min int, @parm2max int,
	@parm3 varchar( 30 ),
	@parm4 varchar( 25 )
AS
	SELECT *
	FROM PurOrdLSDet
	WHERE PONbr LIKE @parm1
	   AND LineID BETWEEN @parm2min AND @parm2max
	   AND InvtID LIKE @parm3
	   AND LotSerNbr LIKE @parm4
	ORDER BY PONbr,
	   LineID,
	   InvtID,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_PONbr_LineID_InvtI] TO [MSDSL]
    AS [dbo];

