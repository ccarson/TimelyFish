 CREATE PROCEDURE ADG_PJPROJ_Descr
	@project varchar(16)
AS
	select	project_Desc
	from	PJPROJ
	where	project = @project

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PJPROJ_Descr] TO [MSDSL]
    AS [dbo];

