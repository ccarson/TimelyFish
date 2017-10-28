 CREATE PROCEDURE TrnsfrDoc_TrnsfrDocNbr_BatNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM TrnsfrDoc
	WHERE TrnsfrDocNbr LIKE @parm1
	   AND BatNbr LIKE @parm2
	ORDER BY TrnsfrDocNbr,
	   BatNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[TrnsfrDoc_TrnsfrDocNbr_BatNbr] TO [MSDSL]
    AS [dbo];

