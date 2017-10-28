 CREATE PROCEDURE IN10990_LotSerMst_InvtID_SiteI
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3min smalldatetime, @parm3max smalldatetime
AS
	SELECT *
	FROM IN10990_LotSerMst
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND ExpDate BETWEEN @parm3min AND @parm3max
	ORDER BY InvtID,
	   SiteID,
	   ExpDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


