 CREATE PROCEDURE WOEvent_WONbr_EventID
	@parm1 varchar( 16 ),
	@parm2min int, @parm2max int
AS
	SELECT *
	FROM WOEvent
	WHERE WONbr LIKE @parm1
	   AND EventID BETWEEN @parm2min AND @parm2max
	ORDER BY WONbr,
	   EventID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOEvent_WONbr_EventID] TO [MSDSL]
    AS [dbo];

