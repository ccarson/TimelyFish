 CREATE PROCEDURE DMG_LocTable_SiteID
 	@parm1 varchar ( 10),
	@parm2 varchar ( 10)
AS
    	Select 	*
	from 	LocTable
        where 	Siteid = @parm1
	  and 	WhseLoc like @parm2
	Order by SiteID, WhseLoc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_LocTable_SiteID] TO [MSDSL]
    AS [dbo];

