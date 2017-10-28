 CREATE PROCEDURE INTran_InvtID_SiteID_PerPost
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 6 )
AS
	SELECT *
	FROM INTran
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND PerPost LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   PerPost

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_InvtID_SiteID_PerPost] TO [MSDSL]
    AS [dbo];

