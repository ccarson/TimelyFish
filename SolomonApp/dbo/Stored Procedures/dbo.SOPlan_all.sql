 CREATE PROCEDURE SOPlan_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3min smalldatetime, @parm3max smalldatetime,
	@parm4 varchar( 2 ),
	@parm5 varchar( 5 )
AS
	SELECT *
	FROM SOPlan
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND PlanDate BETWEEN @parm3min AND @parm3max
	   AND PlanType LIKE @parm4
	   AND PlanRef LIKE @parm5
	ORDER BY InvtID,
	   SiteID,
	   PlanDate,
	   PlanType,
	   PlanRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPlan_all] TO [MSDSL]
    AS [dbo];

