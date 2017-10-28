 CREATE PROCEDURE DMG_EDI_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	EDSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_EDI_Installed] TO [MSDSL]
    AS [dbo];

