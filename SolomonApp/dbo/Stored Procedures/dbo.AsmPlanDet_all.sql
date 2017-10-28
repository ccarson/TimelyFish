 CREATE PROCEDURE AsmPlanDet_all
	@parm1 varchar( 6 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM AsmPlanDet
	WHERE PlanID LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY PlanID,
	   InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlanDet_all] TO [MSDSL]
    AS [dbo];

