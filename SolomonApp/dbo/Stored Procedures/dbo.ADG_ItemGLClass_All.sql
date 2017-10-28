 CREATE PROCEDURE ADG_ItemGLClass_All
	@GLClassID varchar(4)
AS
	SELECT *
	FROM ItemGLClass
	WHERE GLClassID LIKE @GLClassID
	ORDER BY GLClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


