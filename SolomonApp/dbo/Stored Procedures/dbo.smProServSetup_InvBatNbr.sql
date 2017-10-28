 CREATE PROCEDURE
	smProServSetup_InvBatNbr
AS
	SELECT
		LastInvBatNbr
	FROM
		smProServSetup

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smProServSetup_InvBatNbr] TO [MSDSL]
    AS [dbo];

