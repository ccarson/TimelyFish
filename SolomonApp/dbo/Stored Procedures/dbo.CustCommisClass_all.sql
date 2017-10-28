 CREATE PROCEDURE CustCommisClass_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM CustCommisClass
	WHERE ClassID LIKE @parm1
	ORDER BY ClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


