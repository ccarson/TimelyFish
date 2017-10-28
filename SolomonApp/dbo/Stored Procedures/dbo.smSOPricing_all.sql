 CREATE PROCEDURE smSOPricing_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 30 )
AS
	SELECT *
	FROM smSOPricing,Inventory
	WHERE CustID LIKE @parm1
	   AND ShipToID LIKE @parm2
	   AND smSoPricing.Invtid LIKE @parm3
	   AND smSOPricing.Invtid = Inventory.Invtid
	ORDER BY
	   smSoPricing.CustID,
	   smSoPricing.ShipToID,
	   smSoPricing.Invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


