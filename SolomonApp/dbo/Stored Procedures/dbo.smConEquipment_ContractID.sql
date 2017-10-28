 CREATE PROCEDURE
	smConEquipment_ContractID
		@parm1	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smConEquipment
 	WHERE
		ContractId = @parm1
			AND
		EquipID  LIKE @parm2
	ORDER BY
		ContractID
		,EquipId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


