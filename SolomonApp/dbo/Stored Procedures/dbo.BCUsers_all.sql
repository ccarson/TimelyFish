 CREATE PROCEDURE BCUsers_all
AS
	SELECT *
	FROM BCUsers

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BCUsers_all] TO [MSDSL]
    AS [dbo];

