 CREATE PROCEDURE LotSerTArch_TranSrc_RefNbr_Inv
	@parm1 varchar( 2 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 30 ),
	@parm4min int, @parm4max int
AS
	SELECT *
	FROM LotSerTArch
	WHERE TranSrc LIKE @parm1
	   AND RefNbr LIKE @parm2
	   AND InvtID LIKE @parm3
	   AND INTranLineID BETWEEN @parm4min AND @parm4max
	ORDER BY TranSrc,
	   RefNbr,
	   InvtID,
	   INTranLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerTArch_TranSrc_RefNbr_Inv] TO [MSDSL]
    AS [dbo];

