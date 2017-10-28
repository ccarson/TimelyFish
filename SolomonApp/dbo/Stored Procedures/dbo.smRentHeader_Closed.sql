 CREATE PROCEDURE smRentHeader_Closed
	@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentHeader
	WHERE
		EquipID = @parm1
			AND
		Status = 'C'
	ORDER BY
		EquipID
		,TransID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentHeader_Closed] TO [MSDSL]
    AS [dbo];

