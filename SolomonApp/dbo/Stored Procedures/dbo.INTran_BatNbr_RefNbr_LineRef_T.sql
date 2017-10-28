 CREATE PROCEDURE INTran_BatNbr_RefNbr_LineRef_T
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 2 )
AS
	SELECT *
	FROM INTran
	WHERE BatNbr LIKE @parm1
	   AND RefNbr LIKE @parm2
	   AND LineRef LIKE @parm3
	   AND TranType LIKE @parm4
	ORDER BY BatNbr,
	   RefNbr,
	   LineRef,
	   TranType

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_BatNbr_RefNbr_LineRef_T] TO [MSDSL]
    AS [dbo];

