 CREATE PROCEDURE ItemAttribs_ClassID_Attrib07
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM ItemAttribs
	WHERE ClassID LIKE @parm1
	   AND Attrib07 LIKE @parm2
	ORDER BY ClassID,
	   Attrib07

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


