 create procedure DMG_Loctable_WhseLoc_Out
	@parm1 		varchar(10),
	@parm2 		varchar(30),
	@parm3 		varchar(30),
	@parm4 		varchar(30),
	@parm5 		varchar(10)
as

	select 	location.* from loctable LT,location
	where	LT.siteid = @parm1
	  and 	((LT.InvtIDValid = 'Y' and LT.InvtID = @parm2 and Location.invtid = @parm3)
	  or 	(LT.InvtIDValid <> 'Y' and Location.invtid = @parm4))
	  and 	LT.whseloc like @parm5
	  and 	LT.siteid = Location.siteid
	  and 	LT.whseloc = Location.whseloc
	Order by LT.WhseLoc

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Loctable_WhseLoc_Out] TO [MSDSL]
    AS [dbo];

