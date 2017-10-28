 CREATE PROCEDURE smAgrPricing_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM smAgrPricing, Inventory
	WHERE AgreementID LIKE @parm1
	   AND smAgrPricing.Invtid LIKE @parm2
	   AND smAgrPricing.Invtid = Inventory.Invtid
	ORDER BY
	   smAgrPricing.AgreementID,
	   smAgrPricing.Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAgrPricing_all] TO [MSDSL]
    AS [dbo];

