 CREATE PROCEDURE POReqHdr_CpnyID_PONbr_ReqNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM POReqHdr
	WHERE CpnyID = @parm1
		AND POnbr = @parm2
	   	AND ReqNbr LIKE @Parm3

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


