 CREATE PROCEDURE smAgrPricing_misc
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM smAgrPricing
	WHERE AgreementID LIKE @parm1
	   AND Invtid LIKE @parm2
	ORDER BY
	   AgreementID,
	   Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAgrPricing_misc] TO [MSDSL]
    AS [dbo];

