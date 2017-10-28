 CREATE PROCEDURE PurchOrd_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM PurchOrd
	WHERE PONbr LIKE @parm1
	ORDER BY PONbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


