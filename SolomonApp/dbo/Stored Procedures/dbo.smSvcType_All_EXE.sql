 CREATE PROCEDURE
	smSvcType_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcType
	WHERE
		EquipmentTypeId LIKE @parm1
	ORDER BY
		EquipmentTypeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


