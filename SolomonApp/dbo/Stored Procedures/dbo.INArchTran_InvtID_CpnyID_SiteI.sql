 CREATE PROCEDURE INArchTran_InvtID_CpnyID_SiteI
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 10 ),
	@parm5min int, @parm5max int
AS
	SELECT *
	FROM INArchTran
	WHERE InvtID LIKE @parm1
	   AND CpnyID LIKE @parm2
	   AND SiteID LIKE @parm3
	   AND WhseLoc LIKE @parm4
	   AND RecordID BETWEEN @parm5min AND @parm5max
	ORDER BY InvtID,
	   CpnyID,
	   SiteID,
	   WhseLoc,
	   RecordID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


