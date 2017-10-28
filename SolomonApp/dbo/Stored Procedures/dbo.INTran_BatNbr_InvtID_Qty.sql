 CREATE PROCEDURE INTran_BatNbr_InvtID_Qty
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 ),
	@parm3min float, @parm3max float
AS
	SELECT *
	FROM INTran
	WHERE BatNbr LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND Qty BETWEEN @parm3min AND @parm3max
	ORDER BY BatNbr,
	   InvtID,
	   Qty

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


