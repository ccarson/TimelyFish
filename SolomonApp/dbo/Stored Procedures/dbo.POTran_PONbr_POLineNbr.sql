 CREATE PROCEDURE POTran_PONbr_POLineNbr
	@parm1 varchar( 10 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM POTran
	WHERE PONbr LIKE @parm1
	   AND POLineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY PONbr,
	   POLineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


