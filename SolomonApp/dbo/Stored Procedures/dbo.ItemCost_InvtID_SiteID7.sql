 CREATE PROCEDURE ItemCost_InvtID_SiteID7
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 )

AS
	SELECT *
	FROM ItemCost
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND LayerType LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   LayerType,
	   SpecificCostID,
	   RcptDate,
	   RcptNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemCost_InvtID_SiteID7] TO [MSDSL]
    AS [dbo];

