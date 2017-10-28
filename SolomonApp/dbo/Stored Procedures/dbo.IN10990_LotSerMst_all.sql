 CREATE PROCEDURE IN10990_LotSerMst_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 25 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 10 )
AS
	SELECT *
	FROM IN10990_LotSerMst
	WHERE InvtID LIKE @parm1
	   AND LotSerNbr LIKE @parm2
	   AND SiteID LIKE @parm3
	   AND WhseLoc LIKE @parm4
	ORDER BY InvtID,
	   LotSerNbr,
	   SiteID,
	   WhseLoc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


