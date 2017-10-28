 CREATE PROCEDURE EDWrkLabelPrint_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM EDWrkLabelPrint
	WHERE ContainerID LIKE @parm1
	ORDER BY ContainerID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


