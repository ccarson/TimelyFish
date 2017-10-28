 CREATE PROCEDURE
smEquipment_All
	@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smEquipment
	WHERE
		EquipmentID LIKE @parm1
	ORDER BY
		EquipmentID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smEquipment_All] TO [MSDSL]
    AS [dbo];

