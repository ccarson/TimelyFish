 create proc ADG_UpdtShip_CancelOrder
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as

	update	SOLot
	set	Status = 'C',
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400'

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status <> 'C'

	update	SOSched
	set	Status = 'C',
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400'

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status <> 'C'

	update	SOLine
	set	Status = 'C',
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400'

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status <> 'C'

	update	SOHeader
	set	Status = 'C',
		LUpd_DateTime = GetDate(),
		LUpd_Prog = 'SQL40400',
		LUpd_User = 'SQL40400',
		NextFunctionID = '',
		NextFunctionClass = '',
		CuryUnshippedBalance = 0,
		UnshippedBalance = 0

	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status <> 'C'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


