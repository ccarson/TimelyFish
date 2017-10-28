 create proc ADG_UpdtShip_GetZeroScheds
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@TodaysDate	smalldatetime
as
	select	LineRef,
		SchedRef,
		QtyOrd

	from	SOSched
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status <> 'C'
	  and	(QtyOrd = 0 or CancelDate <= @TodaysDate and @TodaysDate <> '')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


