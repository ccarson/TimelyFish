 CREATE PROCEDURE smConPricing_ContractID
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM smConPricing
	WHERE ContractID = @parm1
	   AND Invtid LIKE @parm2
	ORDER BY  Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smConPricing_ContractID] TO [MSDSL]
    AS [dbo];

