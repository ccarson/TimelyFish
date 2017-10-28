 CREATE PROCEDURE IN10990_ItemCost_InvtID_SiteID
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 2 ),
	@parm4min smalldatetime, @parm4max smalldatetime,
	@parm5 varchar( 15 )
AS
	SELECT *
	FROM IN10990_ItemCost
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND LayerType LIKE @parm3
	   AND RcptDate BETWEEN @parm4min AND @parm4max
	   AND RcptNbr LIKE @parm5
	ORDER BY InvtID,
	   SiteID,
	   LayerType,
	   RcptDate,
	   RcptNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10990_ItemCost_InvtID_SiteID] TO [MSDSL]
    AS [dbo];

