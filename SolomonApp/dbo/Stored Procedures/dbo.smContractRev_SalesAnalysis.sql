 CREATE PROCEDURE
	smContractRev_SalesAnalysis
		@parm1	smalldatetime
		,@parm2	smalldatetime
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smContractRev, smContract
	WHERE
		smContractRev.RevDate BETWEEN @parm1 AND @parm2
			AND
		smContractRev.Status = 'P'
			AND
		smContractRev.ContractID = smContract.ContractId
			AND
		smContract.BranchId LIKE @parm3

	ORDER BY
		smContractRev.ContractID
		,RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_SalesAnalysis] TO [MSDSL]
    AS [dbo];

