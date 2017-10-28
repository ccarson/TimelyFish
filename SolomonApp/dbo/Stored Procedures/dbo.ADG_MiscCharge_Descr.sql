 CREATE PROCEDURE ADG_MiscCharge_Descr
	@MiscChrgID varchar(10)
AS
	SELECT Descr
	FROM MiscCharge
	WHERE MiscChrgID = @MiscChrgID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_MiscCharge_Descr] TO [MSDSL]
    AS [dbo];

