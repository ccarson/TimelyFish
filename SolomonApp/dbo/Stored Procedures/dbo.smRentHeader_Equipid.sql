 CREATE PROCEDURE
	smRentHeader_Equipid
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		smRentHeader
	WHERE
		EquipID = @parm1
			AND
		Status IN ('N', 'R','P')
	ORDER BY
		EquipID
		,TransID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentHeader_Equipid] TO [MSDSL]
    AS [dbo];

