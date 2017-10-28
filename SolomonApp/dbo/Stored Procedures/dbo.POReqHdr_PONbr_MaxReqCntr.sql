 CREATE PROCEDURE POReqHdr_PONbr_MaxReqCntr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	-- Need to do these casts because we want the numeric max.
	-- The char max thinks '9' is bigger than '10'.
	SELECT 	CAST( MAX( CAST(ReqCntr AS INTEGER) ) AS CHAR(2) )
	FROM 	POReqHdr
	WHERE 	CpnyID = @parm1
	  AND 	PONbr = @Parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


