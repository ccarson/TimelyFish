 CREATE PROCEDURE LotSerT_InvtID_LotSerNbr_TranT
	@parm1 varchar( 30 ),
	@parm2 varchar( 25 ),
	@parm3 varchar( 2 ),
	@parm4min smalldatetime, @parm4max smalldatetime,
	@parm5min smalldatetime, @parm5max smalldatetime
AS
	SELECT *
	FROM LotSerT
	WHERE InvtID LIKE @parm1
	   AND LotSerNbr LIKE @parm2
	   AND TranType LIKE @parm3
	   AND TranDate BETWEEN @parm4min AND @parm4max
	   AND TranTime BETWEEN @parm5min AND @parm5max
	ORDER BY InvtID,
	   LotSerNbr,
	   TranType,
	   TranDate,
	   TranTime

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


