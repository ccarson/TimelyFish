 CREATE PROCEDURE PurOrdDet_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 5 )
AS
	SELECT *
	FROM PurOrdDet
	WHERE PONbr LIKE @parm1
	   AND LineRef LIKE @parm2
	ORDER BY PONbr,
	   LineRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_all] TO [MSDSL]
    AS [dbo];

