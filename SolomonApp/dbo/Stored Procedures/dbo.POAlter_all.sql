 CREATE PROCEDURE POAlter_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POAlter
	WHERE ReqNbr LIKE @parm1
	ORDER BY ReqNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


