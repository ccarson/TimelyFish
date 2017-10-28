 CREATE PROCEDURE Item2Hist_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 4 )
AS
	SELECT *
	FROM Item2Hist
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND FiscYr LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   FiscYr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Item2Hist_all] TO [MSDSL]
    AS [dbo];

