 CREATE PROCEDURE
	smRentHeader_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentHeader
	WHERE
		TransId LIKE @parm1
	ORDER BY
		TransID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentHeader_All] TO [MSDSL]
    AS [dbo];

