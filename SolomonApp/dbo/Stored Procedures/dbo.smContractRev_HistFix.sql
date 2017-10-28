 CREATE PROCEDURE
	smContractRev_HistFix
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
		RevFlag = 1
			AND
		Status = 'P'
	ORDER BY
		ContractId
		,RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_HistFix] TO [MSDSL]
    AS [dbo];

