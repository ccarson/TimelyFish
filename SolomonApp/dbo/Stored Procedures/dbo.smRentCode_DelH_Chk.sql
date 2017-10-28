 CREATE PROCEDURE
	smRentCode_DelH_Chk
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentHeader
	WHERE
		RentalID = @parm1
	ORDER BY
		RentalID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentCode_DelH_Chk] TO [MSDSL]
    AS [dbo];

