 CREATE PROCEDURE DMG_ProdMgr_All
	@ProdMgrID varchar(10)
AS
	SELECT *
	FROM ProdMgr
	WHERE ProdMgrID LIKE @ProdMgrID
	ORDER BY ProdMgrID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


