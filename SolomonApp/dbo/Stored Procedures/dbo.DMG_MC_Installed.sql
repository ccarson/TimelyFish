 Create PROCEDURE DMG_MC_Installed
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	vs_MCsetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


