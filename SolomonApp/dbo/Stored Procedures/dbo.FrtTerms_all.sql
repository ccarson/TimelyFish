 CREATE PROCEDURE FrtTerms_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM FrtTerms
	WHERE FrtTermsID LIKE @parm1
	ORDER BY FrtTermsID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FrtTerms_all] TO [MSDSL]
    AS [dbo];

