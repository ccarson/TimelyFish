 CREATE PROCEDURE smConPricing_Misc
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM smConPricing
	WHERE ContractID LIKE @parm1
	   AND Invtid LIKE @parm2
	ORDER BY ContractID,
	   Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPricing_Misc] TO [MSDSL]
    AS [dbo];

