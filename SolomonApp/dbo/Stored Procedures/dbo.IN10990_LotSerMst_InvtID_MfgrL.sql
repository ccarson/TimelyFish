 CREATE PROCEDURE IN10990_LotSerMst_InvtID_MfgrL
	@parm1 varchar( 30 ),
	@parm2 varchar( 25 )
AS
	SELECT *
	FROM IN10990_LotSerMst
	WHERE InvtID LIKE @parm1
	   AND MfgrLotSerNbr LIKE @parm2
	ORDER BY InvtID,
	   MfgrLotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IN10990_LotSerMst_InvtID_MfgrL] TO [MSDSL]
    AS [dbo];

