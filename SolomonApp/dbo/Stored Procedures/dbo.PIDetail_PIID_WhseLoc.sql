 CREATE PROCEDURE PIDetail_PIID_WhseLoc
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM PIDetail
	WHERE PIID LIKE @parm1
	   AND WhseLoc LIKE @parm2
	ORDER BY PIID,
	   WhseLoc

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PIDetail_PIID_WhseLoc] TO [MSDSL]
    AS [dbo];

