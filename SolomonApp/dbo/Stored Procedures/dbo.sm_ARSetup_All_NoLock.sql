 CREATE PROCEDURE
	sm_ARSetup_All_NoLock
AS
	SELECT
		*
	FROM
		ARSetup (NOLOCK)
	ORDER BY
		SetupId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


