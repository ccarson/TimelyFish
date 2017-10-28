 CREATE PROCEDURE INUnit_NoteID
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM INUnit
	WHERE NoteID BETWEEN @parm1min AND @parm1max
	ORDER BY NoteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INUnit_NoteID] TO [MSDSL]
    AS [dbo];

