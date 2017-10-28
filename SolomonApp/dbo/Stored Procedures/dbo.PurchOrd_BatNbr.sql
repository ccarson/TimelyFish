 CREATE PROCEDURE PurchOrd_BatNbr
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM PurchOrd
	WHERE BatNbr LIKE @parm1
	ORDER BY BatNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


