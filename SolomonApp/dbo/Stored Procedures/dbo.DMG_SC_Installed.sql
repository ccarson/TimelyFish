 CREATE PROCEDURE DMG_SC_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	smConSetup(nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


