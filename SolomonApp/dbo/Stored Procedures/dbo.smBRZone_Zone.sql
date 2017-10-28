 CREATE PROCEDURE
	smBRZone_Zone
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smBRZone
	WHERE
		ZoneID LIKE @parm1
	ORDER BY
		ZoneID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smBRZone_Zone] TO [MSDSL]
    AS [dbo];

