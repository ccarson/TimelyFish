 CREATE PROCEDURE INTran_BatNbr_InvtID_SiteID_Wh
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 10 ),
	@parm5 varchar( 15 ),
	@parm6min smallint, @parm6max smallint,
	@parm7min int, @parm7max int
AS
	SELECT *
	FROM INTran
	WHERE BatNbr LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND SiteID LIKE @parm3
	   AND WhseLoc LIKE @parm4
	   AND RefNbr LIKE @parm5
	   AND LineNbr BETWEEN @parm6min AND @parm6max
	   AND RecordID BETWEEN @parm7min AND @parm7max
	ORDER BY BatNbr,
	   InvtID,
	   SiteID,
	   WhseLoc,
	   RefNbr,
	   LineNbr,
	   RecordID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


