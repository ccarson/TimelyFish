 create proc ADG_UpdtShip_GetAccts
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select	ARAcct,
		ARSub,
		COGSAcct,
		COGSSub,
		DiscAcct,
		DiscSub,
		FrtAcct,
		FrtSub,
		InvAcct,
		InvSub,
		MiscAcct,
		MiscSub,
		SlsAcct,
		SlsSub,
		WholeOrdDiscAcct,
		WholeOrdDiscSub

	from	SOType
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


