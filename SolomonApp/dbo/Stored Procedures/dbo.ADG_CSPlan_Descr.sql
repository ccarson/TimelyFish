 CREATE PROCEDURE ADG_CSPlan_Descr
	@parm1 varchar(10)
AS
	SELECT Descr
	FROM CSPlan
	WHERE PlanID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


