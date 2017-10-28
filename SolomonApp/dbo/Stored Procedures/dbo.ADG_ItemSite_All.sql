 CREATE PROCEDURE ADG_ItemSite_All
	@parm1 varchar (30),
	@parm2 varchar (10)
AS
	SELECT *
	FROM ItemSite
        WHERE InvtId = @parm1 AND
		SiteId like @parm2
        ORDER BY InvtID, SiteId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


