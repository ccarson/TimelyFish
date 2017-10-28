 CREATE PROCEDURE BOMTran_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 30 ),
	@parm4 varchar( 10 ),
	@parm5min smallint, @parm5max smallint
AS
	SELECT *
	FROM BOMTran
	WHERE CpnyID LIKE @parm1
	   AND RefNbr LIKE @parm2
	   AND KitID LIKE @parm3
	   AND KitSiteID LIKE @parm4
	   AND BOMLineNbr BETWEEN @parm5min AND @parm5max
	ORDER BY CpnyID,
	   RefNbr,
	   KitID,
	   KitSiteID,
	   BOMLineNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_all] TO [MSDSL]
    AS [dbo];

