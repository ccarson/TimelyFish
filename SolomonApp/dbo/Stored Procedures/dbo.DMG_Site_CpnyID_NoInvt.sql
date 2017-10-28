 CREATE PROCEDURE DMG_Site_CpnyID_NoInvt
	@parm1 varchar(10),
	@parm2 varchar(10)
	AS
	SELECT 	*
	FROM 	Site
	WHERE   CpnyID = @parm1
	  and 	SiteId like @parm2
	ORDER BY SiteId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Site_CpnyID_NoInvt] TO [MSDSL]
    AS [dbo];

