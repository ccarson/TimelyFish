 CREATE PROCEDURE SOPlan_CpnyID_SOShipperID_SOSh
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM SOPlan
	WHERE CpnyID LIKE @parm1
	   AND SOShipperID LIKE @parm2
	   AND SOShipperLineRef LIKE @parm3
	ORDER BY CpnyID,
	   SOShipperID,
	   SOShipperLineRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOPlan_CpnyID_SOShipperID_SOSh] TO [MSDSL]
    AS [dbo];

