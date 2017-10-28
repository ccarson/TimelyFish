 CREATE PROCEDURE CreditMgr_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM CreditMgr
	WHERE CreditMgrID LIKE @parm1
	ORDER BY CreditMgrID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


