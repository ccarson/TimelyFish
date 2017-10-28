 CREATE PROCEDURE LotSerMst_InvtID_SiteID_Status
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 1 ),
	@parm4 varchar( 25 )
AS
	SELECT *
	FROM LotSerMst
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND Status LIKE @parm3
	   AND LotSerNbr LIKE @parm4
	ORDER BY InvtID,
	   SiteID,
	   Status,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


