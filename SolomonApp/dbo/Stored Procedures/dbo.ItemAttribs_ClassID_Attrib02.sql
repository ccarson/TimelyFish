 CREATE PROCEDURE ItemAttribs_ClassID_Attrib02
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM ItemAttribs
	WHERE ClassID LIKE @parm1
	   AND Attrib02 LIKE @parm2
	ORDER BY ClassID,
	   Attrib02

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemAttribs_ClassID_Attrib02] TO [MSDSL]
    AS [dbo];

