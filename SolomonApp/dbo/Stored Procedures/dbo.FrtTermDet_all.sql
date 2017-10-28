 CREATE PROCEDURE FrtTermDet_all
	@parm1 varchar( 10 ),
	@parm2min float, @parm2max float
AS
	SELECT *
	FROM FrtTermDet
	WHERE FrtTermsID LIKE @parm1
	   AND MinOrderVal BETWEEN @parm2min AND @parm2max
	ORDER BY FrtTermsID,
	   MinOrderVal

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FrtTermDet_all] TO [MSDSL]
    AS [dbo];

