 CREATE PROCEDURE DMG_ProdMgr_Name
	@parm1 varchar(10)
AS
	SELECT	Descr
	FROM 	ProdMgr
	WHERE 	ProdMgrID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


