 CREATE PROCEDURE LotSerTArch_InvtID_LotSerNbr_C
	@parm1 varchar( 30 ),
	@parm2 varchar( 25 ),
	@parm3 varchar( 15 )
AS
	SELECT *
	FROM LotSerTArch
	WHERE InvtID LIKE @parm1
	   AND LotSerNbr LIKE @parm2
	   AND CustID LIKE @parm3
	ORDER BY InvtID,
	   LotSerNbr,
	   CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerTArch_InvtID_LotSerNbr_C] TO [MSDSL]
    AS [dbo];

