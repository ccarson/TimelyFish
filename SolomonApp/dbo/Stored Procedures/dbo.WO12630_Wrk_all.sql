 CREATE PROCEDURE WO12630_Wrk_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 ),
	@parm4min smalldatetime, @parm4max smalldatetime,
	@parm5 varchar( 3 ),
	@parm6 varchar( 16 ),
	@parm7 varchar( 5 )
AS
	SELECT *
	FROM WO12630_Wrk
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND InvtID LIKE @parm2
	   AND SiteID LIKE @parm3
	   AND TxnDate BETWEEN @parm4min AND @parm4max
	   AND Source LIKE @parm5
	   AND ID LIKE @parm6
	   AND PlanRef LIKE @parm7
	ORDER BY RI_ID,
	   InvtID,
	   SiteID,
	   TxnDate,
	   Source,
	   ID,
	   PlanRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WO12630_Wrk_all] TO [MSDSL]
    AS [dbo];

