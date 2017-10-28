 CREATE PROCEDURE
	smRentHeader_Open
		@parm1	varchar(10)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smRentHeader
	WHERE
		TransId =  @parm1
			AND
		EquipId = @parm2
			AND
		Status IN ('N', 'R','P')
	ORDER BY
		TransID
		,EquipID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentHeader_Open] TO [MSDSL]
    AS [dbo];

