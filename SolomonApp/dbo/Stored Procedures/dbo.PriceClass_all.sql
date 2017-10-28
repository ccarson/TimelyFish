 CREATE PROCEDURE PriceClass_all
	@parm1 varchar( 1 ),
	@parm2 varchar( 6 )
AS
	SELECT *
	FROM PriceClass
	WHERE PriceClassType LIKE @parm1
	   AND PriceClassID LIKE @parm2
	ORDER BY PriceClassType,
	   PriceClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceClass_all] TO [MSDSL]
    AS [dbo];

