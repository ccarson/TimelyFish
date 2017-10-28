 CREATE PROCEDURE WrkComponent_CmpnentType_Cmpne
	@parm1 varchar( 1 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM WrkComponent
	WHERE CmpnentType LIKE @parm1
	   AND CmpnentID LIKE @parm2
	ORDER BY CmpnentType,
	   CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkComponent_CmpnentType_Cmpne] TO [MSDSL]
    AS [dbo];

