 CREATE PROCEDURE CSPlan_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM CSPlan
	WHERE PlanID LIKE @parm1
	ORDER BY PlanID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


