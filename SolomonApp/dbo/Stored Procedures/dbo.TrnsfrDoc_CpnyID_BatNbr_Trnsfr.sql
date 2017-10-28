 CREATE PROCEDURE TrnsfrDoc_CpnyID_BatNbr_Trnsfr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE CpnyID LIKE @parm1
	   AND BatNbr LIKE @parm2
	   AND TrnsfrDocNbr LIKE @parm3
	ORDER BY CpnyID,
	   BatNbr,
	   TrnsfrDocNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_CpnyID_BatNbr_Trnsfr] TO [MSDSL]
    AS [dbo];

