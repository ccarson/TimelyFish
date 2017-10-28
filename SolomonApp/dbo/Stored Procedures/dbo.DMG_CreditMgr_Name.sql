 CREATE PROCEDURE DMG_CreditMgr_Name
	@parm1 varchar(10)
AS
	SELECT CreditMgrName
	FROM CreditMgr
	WHERE CreditMgrID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditMgr_Name] TO [MSDSL]
    AS [dbo];

