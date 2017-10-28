 CREATE PROCEDURE
	smRentCodes_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentCodes
	WHERE
		RentalID LIKE @parm1
	ORDER BY
		RentalId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentCodes_All] TO [MSDSL]
    AS [dbo];

