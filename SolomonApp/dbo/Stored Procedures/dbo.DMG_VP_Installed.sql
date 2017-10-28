 CREATE PROCEDURE DMG_VP_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	VPSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


