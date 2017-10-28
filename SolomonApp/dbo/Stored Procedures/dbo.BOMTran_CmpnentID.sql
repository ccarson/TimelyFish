 CREATE PROCEDURE BOMTran_CmpnentID
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM BOMTran
	WHERE CmpnentID LIKE @parm1
	ORDER BY CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_CmpnentID] TO [MSDSL]
    AS [dbo];

