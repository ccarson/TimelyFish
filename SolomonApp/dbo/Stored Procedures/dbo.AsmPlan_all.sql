 CREATE PROCEDURE AsmPlan_all
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM AsmPlan
	WHERE PlanID LIKE @parm1
	ORDER BY PlanID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AsmPlan_all] TO [MSDSL]
    AS [dbo];

