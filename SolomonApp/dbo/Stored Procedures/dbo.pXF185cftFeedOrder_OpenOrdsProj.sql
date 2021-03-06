﻿CREATE PROCEDURE pXF185cftFeedOrder_OpenOrdsProj 
	@parm1 varchar (6), 
	@parm2 smalldatetime, 
	@parm3 varchar (10) 
	as 
	SELECT * FROM cftFeedOrder 
	WHERE MillId LIKE @parm1 
	AND DateSched <= @parm2 
	AND CpnyId = @parm3
	AND Exists (SELECT * FROM cftOrderStatus WHERE Status = cftFeedOrder.Status AND RelFlg = 1)
	ORDER BY Project, OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFeedOrder_OpenOrdsProj] TO [MSDSL]
    AS [dbo];

