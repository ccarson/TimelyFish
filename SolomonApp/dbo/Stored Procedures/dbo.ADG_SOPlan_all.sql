 CREATE PROCEDURE ADG_SOPlan_all
	@parm1 varchar(30),
	@parm2 varchar(10)
AS
	SELECT *
	FROM SOPlan
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	ORDER BY DisplaySeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


