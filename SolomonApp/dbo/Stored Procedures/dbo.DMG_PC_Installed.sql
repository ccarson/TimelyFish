 CREATE PROCEDURE DMG_PC_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	PCSetup (nolock)
	where	S4Future3 = 'S'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


