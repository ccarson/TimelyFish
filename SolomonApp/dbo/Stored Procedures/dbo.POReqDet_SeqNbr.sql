 CREATE PROCEDURE POReqDet_SeqNbr
	@parm1 varchar( 4 )
AS
	SELECT *
	FROM POReqDet
	WHERE SeqNbr LIKE @parm1
	ORDER BY SeqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


