 CREATE PROCEDURE
	smRentCode_Del_Chk
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		RentalID = @parm1
	ORDER BY
		RentalID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentCode_Del_Chk] TO [MSDSL]
    AS [dbo];

