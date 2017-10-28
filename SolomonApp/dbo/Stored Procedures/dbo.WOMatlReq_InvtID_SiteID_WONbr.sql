 CREATE PROCEDURE WOMatlReq_InvtID_SiteID_WONbr
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 16 )
AS
	SELECT *
	FROM WOMatlReq
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND WONbr LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   WONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


