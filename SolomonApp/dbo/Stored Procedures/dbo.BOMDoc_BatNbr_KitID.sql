 CREATE PROCEDURE BOMDoc_BatNbr_KitID
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM BOMDoc
	WHERE BatNbr LIKE @parm1
	   AND KitID LIKE @parm2
	ORDER BY BatNbr,
	   KitID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMDoc_BatNbr_KitID] TO [MSDSL]
    AS [dbo];

