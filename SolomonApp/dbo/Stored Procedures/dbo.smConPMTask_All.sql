 CREATE PROCEDURE
	smConPMTask_All
		@parm1	varchar(10)
		,@parm2 varchar(10)
		,@parm3	varchar(10)
AS
	SELECT
		*
	FROM
		smConPMTask
 	WHERE
		smConPMTask.ContractId LIKE @parm1
			AND
		smConPMTask.EquipID  LIKE @parm2
			AND
		smConPMTask.PMCode LIKE @parm3
	ORDER BY
		smConPMTask.ContractID
		,smConPMTask.EquipId
		,smConPMTask.PMCode
		,smConPMTask.PMDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPMTask_All] TO [MSDSL]
    AS [dbo];

