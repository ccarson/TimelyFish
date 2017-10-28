 CREATE PROCEDURE CustSlsper_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM CustSlsper
	WHERE CustID LIKE @parm1
	   AND SlsperID LIKE @parm2
	ORDER BY CustID,
	   SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustSlsper_all] TO [MSDSL]
    AS [dbo];

