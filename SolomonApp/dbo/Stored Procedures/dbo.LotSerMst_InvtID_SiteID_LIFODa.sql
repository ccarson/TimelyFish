 CREATE PROCEDURE LotSerMst_InvtID_SiteID_LIFODa
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3min smalldatetime, @parm3max smalldatetime
AS
	SELECT *
	FROM LotSerMst
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND LIFODate BETWEEN @parm3min AND @parm3max
	ORDER BY InvtID,
	   SiteID,
	   LIFODate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


