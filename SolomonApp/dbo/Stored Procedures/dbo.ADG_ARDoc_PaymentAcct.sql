 create proc ADG_ARDoc_PaymentAcct
	@CpnyID		varchar(10),
	@PmtTypeID	varchar(4)
as
	select	CashAcct,
		CashSub

	from	PmtType

	where	CpnyID = @CpnyID
	  and	PmtTypeID = @PmtTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


