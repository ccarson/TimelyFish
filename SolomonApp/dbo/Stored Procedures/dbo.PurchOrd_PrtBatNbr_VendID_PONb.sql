 CREATE PROCEDURE PurchOrd_PrtBatNbr_VendID_PONb
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM PurchOrd
	WHERE PrtBatNbr LIKE @parm1
	   AND VendID LIKE @parm2
	   AND PONbr LIKE @parm3
	ORDER BY PrtBatNbr,
	   VendID,
	   PONbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


