 CREATE PROCEDURE WOLotSerT_CpnyID_BatNbr_TranSD
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 5 ),
	@parm5 varchar( 5 ),
	@parm6 varchar( 24 ),
	@parm7 varchar( 5 )
AS
	SELECT *
	FROM WOLotSerT
	WHERE CpnyID LIKE @parm1
	   AND BatNbr LIKE @parm2
	   AND TranSDType LIKE @parm3
	   AND TranLineRef LIKE @parm4
	   AND TranType LIKE @parm5
	   AND PJTK_Key LIKE @parm6
	   AND LineRef LIKE @parm7
	ORDER BY CpnyID,
	   BatNbr,
	   TranSDType,
	   TranLineRef,
	   TranType,
	   PJTK_Key,
	   LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


