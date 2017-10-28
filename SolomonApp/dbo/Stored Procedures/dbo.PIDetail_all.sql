 CREATE PROCEDURE PIDetail_all
	@parm1 varchar( 10 ),
	@parm2min int, @parm2max int
AS
	SELECT *
	FROM PIDetail
	WHERE PIID LIKE @parm1
	   AND Number BETWEEN @parm2min AND @parm2max
	ORDER BY PIID,
	   Number

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_all] TO [MSDSL]
    AS [dbo];

