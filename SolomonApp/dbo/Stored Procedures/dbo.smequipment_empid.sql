 CREATE PROCEDURE
	smequipment_empid
		@parm1	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smEquipment
	WHERE
		EquipmentEmployeeID = @parm1
			AND
		EquipmentID LIKE @parm2
	ORDER BY
		EquipmentEmployeeID
		,EquipmentID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smequipment_empid] TO [MSDSL]
    AS [dbo];

