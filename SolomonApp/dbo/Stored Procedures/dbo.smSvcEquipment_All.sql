 CREATE PROCEDURE
	smSvcEquipment_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcEquipment
	WHERE
		EquipID LIKE @parm1
	ORDER BY
		EquipID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


