 CREATE PROCEDURE IRAddOnHand_InvtID_OnDate_Site
	@parm1 varchar( 30 ),
	@parm2min smalldatetime, @parm2max smalldatetime,
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM IRAddOnHand
	WHERE InvtID LIKE @parm1
	   AND OnDate BETWEEN @parm2min AND @parm2max
	   AND SiteID LIKE @parm3
	ORDER BY InvtID,
	   OnDate,
	   SiteID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRAddOnHand_InvtID_OnDate_Site] TO [MSDSL]
    AS [dbo];

