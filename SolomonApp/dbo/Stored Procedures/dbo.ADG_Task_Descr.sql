 CREATE PROCEDURE ADG_Task_Descr
	@parm1 varchar(16),
	@parm2 varchar(32)
AS
	SELECT pjt_entity_desc
	FROM   PJPENT
	WHERE  project = @parm1
	  AND  pjt_entity = @parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Task_Descr] TO [MSDSL]
    AS [dbo];

