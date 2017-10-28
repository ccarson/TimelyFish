 CREATE PROCEDURE LCVoucher_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 10 ),
	@parm5min smallint, @parm5max smallint
AS
	SELECT *
	FROM LCVoucher
	WHERE APBatNbr LIKE @parm1
	   AND APRefNbr LIKE @parm2
	   AND APLineRef LIKE @parm3
	   AND RcptNbr LIKE @parm4
	   AND LineNbr BETWEEN @parm5min AND @parm5max
	ORDER BY LineNbr
-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_all] TO [MSDSL]
    AS [dbo];

