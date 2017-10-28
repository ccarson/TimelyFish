 CREATE PROCEDURE POTran_RcptNbr_LineRef_LineNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 ),
	@parm3min smallint, @parm3max smallint
AS
	SELECT *
	FROM POTran
	WHERE RcptNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	   AND LineNbr BETWEEN @parm3min AND @parm3max
	ORDER BY RcptNbr,
	   LineRef,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_LineRef_LineNbr] TO [MSDSL]
    AS [dbo];

