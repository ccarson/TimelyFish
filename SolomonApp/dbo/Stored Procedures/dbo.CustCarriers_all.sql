 CREATE PROCEDURE CustCarriers_all
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM CustCarriers
	WHERE CustID LIKE @parm1
	   AND CarrierID LIKE @parm2
	ORDER BY CustID,
	   CarrierID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


