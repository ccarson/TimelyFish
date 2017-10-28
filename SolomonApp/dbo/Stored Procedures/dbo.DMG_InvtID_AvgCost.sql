 create proc DMG_InvtID_AvgCost

	@InvtID varchar(30)
as
	select	case when ltrim(rtrim(ValMthd)) = 'A' then 1 else 0 end
	from	Inventory
	where	InvtID = @InvtID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_InvtID_AvgCost] TO [MSDSL]
    AS [dbo];

