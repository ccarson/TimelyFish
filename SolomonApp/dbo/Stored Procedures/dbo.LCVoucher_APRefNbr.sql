 CREATE PROCEDURE LCVoucher_APRefNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM LCVoucher
	WHERE APRefNbr LIKE @parm1
	ORDER BY APRefNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_APRefNbr] TO [MSDSL]
    AS [dbo];

