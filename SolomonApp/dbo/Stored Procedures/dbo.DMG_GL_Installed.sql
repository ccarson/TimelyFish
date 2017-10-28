 CREATE PROCEDURE DMG_GL_Installed
AS
	select	case when count(*) > 0
		then 1
		else 0
		end
	from	GLSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


