 CREATE PROCEDURE LotSerMst_ShipContCode_InvtID_
	@parm1 varchar( 20 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 25 )
AS
	SELECT *
	FROM LotSerMst
	WHERE ShipContCode LIKE @parm1
	   AND InvtID LIKE @parm2
	   AND LotSerNbr LIKE @parm3
	ORDER BY ShipContCode,
	   InvtID,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


