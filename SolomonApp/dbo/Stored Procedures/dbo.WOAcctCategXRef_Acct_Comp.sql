 CREATE PROCEDURE WOAcctCategXRef_Acct_Comp
	@parm1 varchar( 16 )
AS
	SELECT *
	FROM WOAcctCategXRef
	WHERE Acct_Comp LIKE @parm1
	ORDER BY Acct_Comp

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOAcctCategXRef_Acct_Comp] TO [MSDSL]
    AS [dbo];

