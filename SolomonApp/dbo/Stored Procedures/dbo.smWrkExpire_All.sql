 CREATE PROCEDURE
	smWrkExpire_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smWrkExpire
	WHERE
		ContractId LIKE @parm1
	ORDER BY
		ContractId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smWrkExpire_All] TO [MSDSL]
    AS [dbo];

