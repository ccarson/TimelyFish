 CREATE PROCEDURE AsmPlanDet_InvtID
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM AsmPlanDet
	WHERE InvtID LIKE @parm1
	ORDER BY InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlanDet_InvtID] TO [MSDSL]
    AS [dbo];

