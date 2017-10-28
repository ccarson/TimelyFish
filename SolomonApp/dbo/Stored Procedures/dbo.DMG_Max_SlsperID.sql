 create procedure DMG_Max_SlsperID
as
	declare @SlsperID1 varchar(10)
	declare @SlsperID2 varchar(10)

	select	@SlsperID1 = max(SlsperID)
	from	SOAddrSlsper

	select	@SlsperID2 = max(SlsperID)
	from	UserSlsper

	if len(rtrim(@SlsperID1)) > len(rtrim(@SlsperID2))
		select @SlsperID1
	else
		select @SlsperID2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


