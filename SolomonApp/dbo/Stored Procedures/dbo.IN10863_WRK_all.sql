 CREATE PROCEDURE IN10863_WRK_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM IN10863_WRK
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND InvtID LIKE @parm2
	   AND SiteID LIKE @parm3
	ORDER BY RI_ID,
	   InvtID,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10863_WRK_all] TO [MSDSL]
    AS [dbo];

