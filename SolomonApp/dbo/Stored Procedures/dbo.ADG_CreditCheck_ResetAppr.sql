 create proc ADG_CreditCheck_ResetAppr
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@CreditRule	varchar(2),
	@ApprDays	smallint,
	@ApprLimit	float,
	@ProgID		varchar(8),
	@UserID		varchar(10)
as
	-- CreditApprDays is only set for rule 'B'.
	if (@CreditRule <> 'B')
		select @ApprDays = 0

	-- CreditApprLimit is only set for rules 'A' and 'B'.
	if (@CreditRule <> 'A')
		if (@CreditRule <> 'B')
			select @ApprLimit = 0

	-- Update SOHeader.
	update	SOHeader
	set	CreditApprDays = @ApprDays,
		CreditApprLimit = @ApprLimit,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID,
		ReleaseValue = 0

	where	CustID = @CustID
	  and	Status = 'O'
	  and	CreditChk = 1
--	  and	CpnyID = @CpnyID

	-- Update SOShipHeader.
	update	SOShipHeader
	set	CreditApprDays = @ApprDays,
		CreditApprLimit = @ApprLimit,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID,
		ReleaseValue = 0

	where	CustID = @CustID
	  and	Status = 'O'
	  and	CreditChk = 1
--	  and	CpnyID = @CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


