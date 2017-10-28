 CREATE PROCEDURE
	smCode_CallTypes
		@parm1	varchar(10)
		,@parm2 varchar(10)
AS
	SELECT
		*
	FROM
		smCodeType
		,smCode
	WHERE
		smCodeType.CallTypeId = @parm1
			AND
		smCodeType.Fault_Id = smCode.Fault_Id
			AND
		smCodeType.Fault_Id LIKE @parm2
	ORDER BY
		smCodeType.Fault_Id

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smCode_CallTypes] TO [MSDSL]
    AS [dbo];

