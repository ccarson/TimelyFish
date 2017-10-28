 CREATE PROCEDURE smConAdjust_all
	@parm1 varchar( 10 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM smConAdjust
	WHERE Batnbr LIKE @parm1
	   AND LineNbr BETWEEN @parm2min AND @parm2max
	ORDER BY Batnbr,
	   LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


