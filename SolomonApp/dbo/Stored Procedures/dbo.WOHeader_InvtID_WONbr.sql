 CREATE PROCEDURE WOHeader_InvtID_WONbr
	@parm1 varchar( 30 ),
	@parm2 varchar( 16 )
AS
	SELECT *
	FROM WOHeader
	WHERE InvtID LIKE @parm1
	   AND WONbr LIKE @parm2
	ORDER BY InvtID,
	   WONbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOHeader_InvtID_WONbr] TO [MSDSL]
    AS [dbo];

