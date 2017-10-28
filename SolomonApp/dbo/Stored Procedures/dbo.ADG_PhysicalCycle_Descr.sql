 CREATE PROCEDURE ADG_PhysicalCycle_Descr
	@parm1 varchar(10)
AS
	SELECT	Descr
	FROM	PICycle
	WHERE	CycleID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PhysicalCycle_Descr] TO [MSDSL]
    AS [dbo];

