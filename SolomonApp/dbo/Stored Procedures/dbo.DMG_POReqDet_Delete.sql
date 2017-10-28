 CREATE PROCEDURE DMG_POReqDet_Delete
	@ReqNbr	 varchar(10),
	@ReqCntr varchar(2)
AS
	DELETE	FROM POReqDet
	WHERE	ReqNbr LIKE @ReqNbr AND
		ReqCntr LIKE @ReqCntr AND
		S4Future09 = 0

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


