 create proc ADG_CreditCheck_HoldOrder
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@CreditHold	smallint,
	@CreditHoldDate	smalldatetime,
	@ProgID		varchar(8),
	@UserID		varchar(10)
as
	update		SOHeader
	set		CreditHold = @CreditHold,
			CreditHoldDate = @CreditHoldDate,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @ProgID,
			LUpd_User = @UserID,
			ReleaseValue = 0
	where		CpnyID = @CpnyID
	and		OrdNbr = @OrdNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


