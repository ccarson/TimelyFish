 CREATE PROCEDURE INTran_InvtID_SiteID_WhseLoc_T
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 ),
	@parm4min smalldatetime, @parm4max smalldatetime,
	@parm5 varchar( 10 ),
	@parm6 varchar( 15 ),
	@parm7min int, @parm7max int
AS
	SELECT *
	FROM INTran
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND WhseLoc LIKE @parm3
	   AND TranDate BETWEEN @parm4min AND @parm4max
	   AND BatNbr LIKE @parm5
	   AND RefNbr LIKE @parm6
	   AND RecordID BETWEEN @parm7min AND @parm7max
	ORDER BY InvtID,
	   SiteID,
	   WhseLoc,
	   TranDate,
	   BatNbr,
	   RefNbr,
	   RecordID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_InvtID_SiteID_WhseLoc_T] TO [MSDSL]
    AS [dbo];

