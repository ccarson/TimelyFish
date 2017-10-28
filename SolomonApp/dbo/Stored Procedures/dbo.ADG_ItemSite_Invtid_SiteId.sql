 CREATE PROCEDURE ADG_ItemSite_Invtid_SiteId
	@parm1 varchar (30),
	@parm2 varchar (10)
AS
        SELECT *
	FROM ItemSite
	WHERE InvtId = @parm1 AND SiteId = @parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


