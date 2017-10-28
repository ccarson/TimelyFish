 CREATE PROCEDURE
	smContractRev_Sales_Post
		@parm1	varchar(6)
		,@parm2	varchar(6)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smContractRev
		,Batch
--		,smContract
	WHERE
		smContractRev.Status = 'P' AND
 		smContractRev.GLBatNbr = Batch.BatNbr AND
		Batch.Module = 'GL' AND
		Batch.PerPost BETWEEN @parm1 AND @parm2 AND

		EXISTS( SELECT * FROM smContract
			WHERE	smContract.ContractID = smContractRev.ContractID ANd
				smContract.BranchID like @parm3)
	ORDER BY
		smContractRev.ContractID
		, smContractRev.RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_Sales_Post] TO [MSDSL]
    AS [dbo];

