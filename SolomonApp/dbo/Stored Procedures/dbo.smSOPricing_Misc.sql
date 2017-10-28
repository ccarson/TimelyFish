 CREATE PROCEDURE smSOPricing_Misc
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 30 )
AS
	SELECT *
	FROM smSOPricing
	WHERE CustID LIKE @parm1
	   AND ShipToID LIKE @parm2
	   AND Invtid LIKE @parm3
	ORDER BY
	   CustID,
	   ShipToID,
	   Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


