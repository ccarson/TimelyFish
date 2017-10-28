 CREATE PROCEDURE
	smEqHistory_EquipID
		@parm1	varchar(10)
		,@parm2 varchar(4)
AS
	SELECT
		*
	FROM
		smEqHistory
	WHERE
		EquipID LIKE @parm1
			AND
		CalYear LIKE @parm2
	ORDER BY
		EquipID
		,CalYear

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEqHistory_EquipID] TO [MSDSL]
    AS [dbo];

