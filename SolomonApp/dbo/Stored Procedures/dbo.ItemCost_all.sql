 CREATE PROCEDURE ItemCost_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 25 ),
	@parm5 varchar( 15 ),
	@parm6min smalldatetime, @parm6max smalldatetime
AS
	SELECT *
	FROM ItemCost
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND LayerType LIKE @parm3
	   AND SpecificCostID LIKE @parm4
	   AND RcptNbr LIKE @parm5
	   AND RcptDate BETWEEN @parm6min AND @parm6max
	ORDER BY InvtID,
	   SiteID,
	   LayerType,
	   SpecificCostID,
	   RcptNbr,
	   RcptDate

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_all] TO [MSDSL]
    AS [dbo];

