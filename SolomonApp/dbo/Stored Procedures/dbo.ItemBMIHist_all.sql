 CREATE PROCEDURE ItemBMIHist_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 4 )
AS
	SELECT *
	FROM ItemBMIHist
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND FiscYr LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   FiscYr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


