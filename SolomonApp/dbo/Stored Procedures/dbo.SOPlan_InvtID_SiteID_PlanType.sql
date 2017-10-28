 CREATE PROCEDURE SOPlan_InvtID_SiteID_PlanType
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )
AS
	SELECT *
	FROM SOPlan
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND PlanType LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   PlanType

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPlan_InvtID_SiteID_PlanType] TO [MSDSL]
    AS [dbo];

