 CREATE PROCEDURE
	smContractRev_ContractID
		@parm1	varchar(10)
		,@parm2 smalldatetime
		,@parm3	smalldatetime
AS
	SELECT
		*
	FROM
		smContractRev
 	WHERE
		ContractId = @parm1
			AND
		RevDate BETWEEN @parm2 AND @parm3
	ORDER BY
		ContractID
		,RevDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContractRev_ContractID] TO [MSDSL]
    AS [dbo];

