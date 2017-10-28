 CREATE PROCEDURE DMG_CreditMgr_All
	@CreditMgrID varchar(10)
AS
	SELECT *
	FROM CreditMgr
	WHERE CreditMgrID LIKE @CreditMgrID
	ORDER BY CreditMgrID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditMgr_All] TO [MSDSL]
    AS [dbo];

