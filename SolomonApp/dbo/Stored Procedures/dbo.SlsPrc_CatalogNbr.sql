 CREATE PROCEDURE SlsPrc_CatalogNbr
	@parm1 varchar( 15 )
AS
	SELECT *
	FROM SlsPrc
	WHERE CatalogNbr LIKE @parm1
	ORDER BY CatalogNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrc_CatalogNbr] TO [MSDSL]
    AS [dbo];

