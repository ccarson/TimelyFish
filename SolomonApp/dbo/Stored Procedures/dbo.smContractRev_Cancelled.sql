 CREATE PROCEDURE smContractRev_Cancelled
			@parm1 varchar(10)
AS
	SELECT * FROM smContractRev
	WHERE
		smContractRev.ContractID = @parm1 AND
		smContractRev.RevFlag = 0 AND
		smContractRev.Status = 'O'

	Order By
		smContractRev.ContractID,
		smContractRev.RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_Cancelled] TO [MSDSL]
    AS [dbo];

