 CREATE PROCEDURE POReqHdr_CpnyID_OrphanReqNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM POReqHdr
	WHERE CpnyID = @parm1
	  	AND PONbr Not In (SELECT PONbr FROM PurchOrd WHERE CpnyID = @parm1)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


