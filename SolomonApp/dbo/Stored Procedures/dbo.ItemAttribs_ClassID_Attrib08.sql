 CREATE PROCEDURE ItemAttribs_ClassID_Attrib08
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM ItemAttribs
	WHERE ClassID LIKE @parm1
	   AND Attrib08 LIKE @parm2
	ORDER BY ClassID,
	   Attrib08

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemAttribs_ClassID_Attrib08] TO [MSDSL]
    AS [dbo];

