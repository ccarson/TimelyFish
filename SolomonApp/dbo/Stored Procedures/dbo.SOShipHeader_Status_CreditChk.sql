 CREATE PROCEDURE SOShipHeader_Status_CreditChk
	@parm1 varchar( 1 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM SOShipHeader
	WHERE Status LIKE @parm1
	   AND CreditChk BETWEEN @parm2min AND @parm2max
	ORDER BY Status,
	   CreditChk

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


