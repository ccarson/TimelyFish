 CREATE PROCEDURE INTran_BatNbr_Acct_Sub
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 24 )
AS
	SELECT *
	FROM INTran
	WHERE BatNbr LIKE @parm1
	   AND Acct LIKE @parm2
	   AND Sub LIKE @parm3
	ORDER BY BatNbr,
	   Acct,
	   Sub

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_Acct_Sub] TO [MSDSL]
    AS [dbo];

