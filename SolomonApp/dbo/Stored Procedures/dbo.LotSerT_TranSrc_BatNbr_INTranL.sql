 CREATE PROCEDURE LotSerT_TranSrc_BatNbr_INTranL
	@parm1 varchar( 2 ),
	@parm2 varchar( 10 ),
	@parm3min int, @parm3max int
AS
	SELECT *
	FROM LotSerT
	WHERE TranSrc LIKE @parm1
	   AND BatNbr LIKE @parm2
	   AND INTranLineID BETWEEN @parm3min AND @parm3max
	ORDER BY TranSrc,
	   BatNbr,
	   INTranLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerT_TranSrc_BatNbr_INTranL] TO [MSDSL]
    AS [dbo];

