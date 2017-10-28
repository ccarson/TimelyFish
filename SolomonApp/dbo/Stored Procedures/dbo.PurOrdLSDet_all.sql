 CREATE PROCEDURE PurOrdLSDet_all
	@parm1 varchar( 10 ),
	@parm2min int, @parm2max int,
	@parm3 varchar( 25 )
AS
	SELECT *
	FROM PurOrdLSDet
	WHERE PONbr LIKE @parm1
	   AND LineID BETWEEN @parm2min AND @parm2max
	   AND MfgrLotSerNbr LIKE @parm3
	ORDER BY PONbr,
	   LineID,
	   MfgrLotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_all] TO [MSDSL]
    AS [dbo];

