 CREATE PROCEDURE WOLotSerT_WONbr_TaskID_TranSDT
	@parm1 varchar( 16 ),
	@parm2 varchar( 32 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 5 ),
	@parm5 varchar( 5 ),
	@parm6 varchar( 24 ),
	@parm7 varchar( 25 )
AS
	SELECT *
	FROM WOLotSerT
	WHERE WONbr LIKE @parm1
	   AND TaskID LIKE @parm2
	   AND TranSDType LIKE @parm3
	   AND TranLineRef LIKE @parm4
	   AND TranType LIKE @parm5
	   AND PJTK_Key LIKE @parm6
	   AND LotSerNbr LIKE @parm7
	ORDER BY WONbr,
	   TaskID,
	   TranSDType,
	   TranLineRef,
	   TranType,
	   PJTK_Key,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


