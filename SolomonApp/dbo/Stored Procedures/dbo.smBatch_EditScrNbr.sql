 CREATE PROCEDURE smBatch_EditScrNbr
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM smBatch
	WHERE EditScrNbr LIKE @parm1
	   AND Batnbr LIKE @parm2
	ORDER BY EditScrNbr,
	   Batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


