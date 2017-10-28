 CREATE PROCEDURE
	smRentHeader_AutoNbr
AS
	SELECT
		LastTranID
	FROM
		smRentSetup

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentHeader_AutoNbr] TO [MSDSL]
    AS [dbo];

