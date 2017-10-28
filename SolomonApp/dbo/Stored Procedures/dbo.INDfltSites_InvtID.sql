 CREATE PROCEDURE INDfltSites_InvtID
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM INDfltSites
	WHERE InvtID LIKE @parm1
	   AND CpnyID LIKE @parm2
	ORDER BY InvtID,
	   CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


