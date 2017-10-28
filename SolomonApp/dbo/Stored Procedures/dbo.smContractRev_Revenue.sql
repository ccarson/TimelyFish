 CREATE PROCEDURE
	smContractRev_Revenue
		@parm1	smalldatetime
		,@parm2 smalldatetime
AS
	SELECT
		*
	FROM
		smContractRev
	WHERE
		RevDate BETWEEN @parm1 AND @parm2
			AND
		RevFlag = 0
			AND
		Status = 'O'
	ORDER BY
		ContractId
		,RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_Revenue] TO [MSDSL]
    AS [dbo];

