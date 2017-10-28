 CREATE PROCEDURE
	smModPMBase_grid
		@parm1	varchar(10)
		,@parm2	varchar(40)
		,@parm3	varchar(10)
AS
	SELECT
		*
	FROM
		smModPMBase
	WHERE
		ManufID = @parm1
			AND
		ModelID = @parm2
			AND
		ContractTypeId LIKE @parm3
     ORDER BY
		ManufId,
		ModelID,
		ContractTypeId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smModPMBase_grid] TO [MSDSL]
    AS [dbo];

