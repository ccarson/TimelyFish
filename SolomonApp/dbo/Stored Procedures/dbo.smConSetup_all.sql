 CREATE PROCEDURE smConSetup_all
AS
	SELECT *
	FROM smConSetup
	ORDER BY
		SetUpID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConSetup_all] TO [MSDSL]
    AS [dbo];

