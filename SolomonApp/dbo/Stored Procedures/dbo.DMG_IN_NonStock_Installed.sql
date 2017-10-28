 CREATE PROCEDURE DMG_IN_NonStock_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	INSetup (nolock)
	where	Init = 0

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_IN_NonStock_Installed] TO [MSDSL]
    AS [dbo];

