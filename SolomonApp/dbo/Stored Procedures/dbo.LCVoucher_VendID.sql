 CREATE PROCEDURE LCVoucher_VendID
	@parm1 varchar( 15 )
AS
	SELECT *
	FROM LCVoucher
	WHERE VendID LIKE @parm1
	ORDER BY VendID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_VendID] TO [MSDSL]
    AS [dbo];

