 CREATE PROCEDURE POTran_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM POTran
	WHERE RcptNbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY RcptNbr,
	   LineRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


