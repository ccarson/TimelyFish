 CREATE PROCEDURE
	smProServSetup_AutoCust
AS
	SELECT
		LastCustId
	FROM
		smProServSetup

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_AutoCust] TO [MSDSL]
    AS [dbo];

