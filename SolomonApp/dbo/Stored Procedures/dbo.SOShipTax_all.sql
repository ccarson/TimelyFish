 CREATE PROCEDURE SOShipTax_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 10 )
AS
	SELECT *
	FROM SOShipTax
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND TaxID LIKE @parm3
	   AND TaxCat LIKE @parm4
	ORDER BY CpnyID,
	   ShipperID,
	   TaxID,
	   TaxCat

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipTax_all] TO [MSDSL]
    AS [dbo];

