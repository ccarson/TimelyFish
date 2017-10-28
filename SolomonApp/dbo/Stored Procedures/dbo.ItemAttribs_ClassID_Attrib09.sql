 CREATE PROCEDURE ItemAttribs_ClassID_Attrib09
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM ItemAttribs
	WHERE ClassID LIKE @parm1
	   AND Attrib09 LIKE @parm2
	ORDER BY ClassID,
	   Attrib09

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


