 CREATE PROCEDURE LotSerT_InvtID_CustID_LotSerNb
	@parm1 varchar( 30 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 25 )
AS
	SELECT *
	FROM LotSerT
	WHERE InvtID LIKE @parm1
	   AND CustID LIKE @parm2
	   AND LotSerNbr LIKE @parm3
	ORDER BY InvtID,
	   CustID,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


