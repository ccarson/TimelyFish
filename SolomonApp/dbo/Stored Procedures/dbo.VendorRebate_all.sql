 CREATE PROCEDURE VendorRebate_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM VendorRebate
	WHERE RebateID LIKE @parm1
	ORDER BY RebateID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


