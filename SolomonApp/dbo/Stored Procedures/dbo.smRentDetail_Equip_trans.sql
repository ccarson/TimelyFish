 CREATE PROCEDURE
	smRentDetail_Equip_trans
		@parm1	varchar(10)
		,@parm2	varchar(10)
		,@parm3Min	smallint
		,@parm3Max	smallint
AS
	SELECT
		*
	FROM
		smRentDetail
	WHERE
		EquipID = @parm1
			AND
		TransId = @parm2
			AND
		LineID BETWEEN @parm3Min AND @Parm3Max
	ORDER BY
		EquipID
		,TransID
		,LineID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smRentDetail_Equip_trans] TO [MSDSL]
    AS [dbo];

