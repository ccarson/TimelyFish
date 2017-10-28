 CREATE PROCEDURE ADG_CSCycle_Descr
	@parm1 varchar(10)
AS
	SELECT Descr
	FROM CSCycle
	WHERE CycleID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


