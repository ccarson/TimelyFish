 CREATE PROCEDURE SOSched_Status_SiteID_DropShip
	@parm1 varchar( 1 ),
	@parm2 varchar( 10 ),
	@parm3min smallint, @parm3max smallint,
	@parm4min smalldatetime, @parm4max smalldatetime
AS
	SELECT *
	FROM SOSched
	WHERE Status LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND DropShip BETWEEN @parm3min AND @parm3max
	   AND CancelDate BETWEEN @parm4min AND @parm4max
	ORDER BY Status,
	   SiteID,
	   DropShip,
	   CancelDate

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOSched_Status_SiteID_DropShip] TO [MSDSL]
    AS [dbo];

