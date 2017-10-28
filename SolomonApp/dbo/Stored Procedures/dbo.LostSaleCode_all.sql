 CREATE PROCEDURE LostSaleCode_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM LostSaleCode
	WHERE LostSaleID LIKE @parm1
	ORDER BY LostSaleID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


