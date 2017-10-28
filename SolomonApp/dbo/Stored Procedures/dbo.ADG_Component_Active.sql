 CREATE PROCEDURE ADG_Component_Active
	@parm1 varchar(30)
AS
	SELECT	*
	FROM	Component
     	WHERE	KitId = @parm1
    	ORDER BY LineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


