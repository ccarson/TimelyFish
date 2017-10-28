 CREATE PROCEDURE AsmPlanDet_NoteID
	@parm1min int, @parm1max int
AS
	SELECT *
	FROM AsmPlanDet
	WHERE NoteID BETWEEN @parm1min AND @parm1max
	ORDER BY NoteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlanDet_NoteID] TO [MSDSL]
    AS [dbo];

