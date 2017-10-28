 CREATE PROCEDURE CustomerEDI_all
	@parm1 varchar( 15 )
AS
	SELECT *
	FROM CustomerEDI
	WHERE CustID LIKE @parm1
	ORDER BY CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustomerEDI_all] TO [MSDSL]
    AS [dbo];

