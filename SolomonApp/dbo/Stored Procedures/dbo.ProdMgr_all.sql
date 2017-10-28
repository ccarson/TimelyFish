 CREATE PROCEDURE ProdMgr_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM ProdMgr
	WHERE ProdMgrID LIKE @parm1
	ORDER BY ProdMgrID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProdMgr_all] TO [MSDSL]
    AS [dbo];

