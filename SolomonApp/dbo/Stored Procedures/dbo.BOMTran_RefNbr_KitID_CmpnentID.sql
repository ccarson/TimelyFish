 CREATE PROCEDURE BOMTran_RefNbr_KitID_CmpnentID
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 30 )
AS
	SELECT *
	FROM BOMTran
	WHERE RefNbr LIKE @parm1
	   AND KitID LIKE @parm2
	   AND CmpnentID LIKE @parm3
	ORDER BY RefNbr,
	   KitID,
	   CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_RefNbr_KitID_CmpnentID] TO [MSDSL]
    AS [dbo];

