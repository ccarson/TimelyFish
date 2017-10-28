 CREATE PROCEDURE Inspection_all
	@parm1 varchar( 30 ),
	@parm2 varchar( 2 )
AS
	SELECT *
	FROM Inspection
	WHERE InvtID LIKE @parm1
	   AND InspID LIKE @parm2
	ORDER BY InvtID,
	   InspID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


