 CREATE PROCEDURE smConSetup_AutoNbr
	AS
	SELECT
		LastBatNbr
	FROM smConSetup

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConSetup_AutoNbr] TO [MSDSL]
    AS [dbo];

