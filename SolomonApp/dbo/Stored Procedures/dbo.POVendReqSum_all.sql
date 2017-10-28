 CREATE PROCEDURE POVendReqSum_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 60 )
AS
	SELECT *
	FROM POVendReqSum
	WHERE ReqNbr LIKE @parm1
	   AND Name LIKE @parm2
	ORDER BY ReqNbr,
	   Name

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POVendReqSum_all] TO [MSDSL]
    AS [dbo];

