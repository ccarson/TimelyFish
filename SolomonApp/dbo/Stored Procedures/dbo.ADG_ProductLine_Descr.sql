 CREATE PROCEDURE ADG_ProductLine_Descr
	@parm1 varchar( 4 )
AS
	SELECT Descr
	FROM ProductLine
	WHERE ProdLineID LIKE @parm1
	ORDER BY ProdLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


