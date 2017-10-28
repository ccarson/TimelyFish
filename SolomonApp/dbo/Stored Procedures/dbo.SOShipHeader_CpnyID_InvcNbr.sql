 CREATE PROCEDURE SOShipHeader_CpnyID_InvcNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID LIKE @parm1
	   AND InvcNbr LIKE @parm2
	ORDER BY CpnyID,
	   InvcNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_CpnyID_InvcNbr] TO [MSDSL]
    AS [dbo];

