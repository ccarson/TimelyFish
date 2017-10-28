 CREATE PROCEDURE LCVoucher_APLineRef
	@parm1 varchar( 5 )
AS
	SELECT *
	FROM LCVoucher
	WHERE APLineRef LIKE @parm1
	ORDER BY APLineRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_APLineRef] TO [MSDSL]
    AS [dbo];

