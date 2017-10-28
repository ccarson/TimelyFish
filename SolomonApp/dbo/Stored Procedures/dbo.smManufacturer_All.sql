 CREATE PROCEDURE
	smManufacturer_All
		@parm1 varchar(10)
AS
	SELECT
		*
	FROM
		smManufacturer
	WHERE
		ManufId LIKE @parm1
	ORDER BY
		ManufId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smManufacturer_All] TO [MSDSL]
    AS [dbo];

