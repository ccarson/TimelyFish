 CREATE PROCEDURE smConDiscount_all
	@parm1 varchar( 10 ),
	@parm2min smalldatetime, @parm2max smalldatetime
AS
	SELECT *
	FROM smConDiscount
	WHERE ContractID LIKE @parm1
	   AND AccrueDate BETWEEN @parm2min AND @parm2max
	ORDER BY ContractID,
	   AccrueDate

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConDiscount_all] TO [MSDSL]
    AS [dbo];

