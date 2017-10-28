 CREATE PROCEDURE ProductLine_all
	@parm1 varchar( 4 )
AS
	SELECT *
	FROM ProductLine
	WHERE ProdLineID LIKE @parm1
	ORDER BY ProdLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProductLine_all] TO [MSDSL]
    AS [dbo];

