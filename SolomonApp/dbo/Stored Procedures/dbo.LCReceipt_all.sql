 CREATE PROCEDURE LCReceipt_all
	@parm1 varchar( 10 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM LCReceipt
	WHERE RcptNbr LIKE @parm1
	   AND LineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY RcptNbr,
	   LineNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


