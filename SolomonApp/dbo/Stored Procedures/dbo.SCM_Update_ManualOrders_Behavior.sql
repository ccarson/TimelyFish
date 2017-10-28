 CREATE PROC SCM_Update_ManualOrders_Behavior
AS
	UPDATE	SOType
	SET	Behavior = 'SO'
	WHERE	Behavior = 'MO'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Update_ManualOrders_Behavior] TO [MSDSL]
    AS [dbo];

