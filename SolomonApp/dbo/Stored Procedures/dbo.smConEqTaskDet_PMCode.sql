 CREATE PROCEDURE
	smConEqTaskDet_PMCode
		@parm1	varchar(10),
		@parm2	varchar(10),
		@parm3	varchar(10),
		@parm4beg	smallint,
		@parm4end 	smallint
AS
	SELECT
		*
	FROM
		smConEqTaskDet
	WHERE
		ContractID = @parm1 AND
		EquipID = @parm2 AND
		PMCode = @parm3	AND
		LineNbr BETWEEN @parm4beg AND @parm4end
	ORDER BY
		ContractID,
		EquipID,
		PMCode,
		LineNbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConEqTaskDet_PMCode] TO [MSDSL]
    AS [dbo];

