 CREATE PROCEDURE LCVoucher_CpnyID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM LCVoucher
	WHERE CpnyID LIKE @parm1
	ORDER BY CpnyID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_CpnyID] TO [MSDSL]
    AS [dbo];

