 CREATE PROCEDURE
	smProServSetup_AutoRef
AS
	SELECT
		LastServiceCall
	FROM
		smProServSetup

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_AutoRef] TO [MSDSL]
    AS [dbo];

