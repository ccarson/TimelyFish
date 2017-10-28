 CREATE PROCEDURE SlsperPlan_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SlsperPlan
	WHERE CpnyId LIKE @parm1
	   AND SlsperID LIKE @parm2
	   AND PlanID LIKE @parm3
	ORDER BY CpnyId,
	   SlsperID,
	   PlanID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsperPlan_all] TO [MSDSL]
    AS [dbo];

