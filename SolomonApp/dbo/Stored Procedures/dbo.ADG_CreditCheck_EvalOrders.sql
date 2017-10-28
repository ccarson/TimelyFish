 create proc ADG_CreditCheck_EvalOrders

	@CpnyIDNotUsed	varchar(10),
	@CustID		varchar(15),
	@CreditRule	varchar(2),
	@OpenBal	float,
	@DaysPastDue	float,
	@ProgID		varchar(8),
	@UserID		varchar(10),
	@MsgLimit	varchar(30),
	@MsgPastDue	varchar(30),
	@MsgCOD		varchar(30),
	@MsgHeld	varchar(30),
	@MsgRelease	varchar(30),
	@MsgDontSell	varchar(30)
as
	-- Variables used in the SELECT.
	declare		@CpnyID			varchar(10)
	declare		@CreditApprDays		smallint
	declare		@CreditApprLimit	float
	declare		@CreditHoldOld		smallint
	declare		@OrdNbr			varchar(15)
	declare		@UnshippedBalance	float
	declare		@ReleaseValue		float
	declare		@COD			smallint

	declare		@ShipperID		varchar(15)
	declare		@TotInvc		float

	-- Other variables.
	declare		@CreditHold		smallint
	declare		@CreditHoldDate		smalldatetime
	declare		@EventDescr		varchar(30)
	declare		@EventType		varchar(4)

	-- Cursor selects all the open orders for the customer.
	declare		SOHCursor		cursor
	for select	h.CpnyID,
			h.CreditApprDays,
			h.CreditApprLimit,
			h.CreditHold,
			h.OrdNbr,
			h.UnshippedBalance,
			h.ReleaseValue,
			t.COD
	from		SOHeader h
	  join		Terms t on t.TermsID = h.TermsID
	where		h.CustID = @CustID
	  and		h.Status = 'O'
	  and		h.CreditChk = 1
--	  and		h.CpnyID = @CpnyID

	open SOHCursor

	fetch next from	SOHCursor
	into	@CpnyID,
		@CreditApprDays,
		@CreditApprLimit,
		@CreditHoldOld,
		@OrdNbr,
		@UnshippedBalance,
		@ReleaseValue,
		@COD

	-- Loop through sales orders.
	while (@@fetch_status <> -1)
	begin
		if (@@fetch_status = 0)
		begin
			select	@CreditHold = 0,
				@EventDescr = ''

			-- Set the Credit hold status based on the credit rule.
			if (@CreditRule in ('A', 'B'))
				if (@OpenBal > @CreditApprLimit)
					select	@CreditHold = 1,
						@EventDescr = @MsgLimit

			if (@CreditRule = 'B')
				if (@CreditHold <> 1)
					if (@DaysPastDue > @CreditApprDays)
						select	@CreditHold = 1,
							@EventDescr = @MsgPastDue

			if (@CreditRule = 'C')
				if (@COD <> 1)
					select	@CreditHold = 1,
						@EventDescr = @MsgCOD

			if (@CreditRule = 'X')
				select	@CreditHold = 1,
					@EventDescr = @MsgDontSell

			if (@CreditRule not in ('A', 'B', 'C', 'N', 'X'))
				select	@CreditHold = 1,
					@EventDescr = @MsgHeld

			-- Don't hold unless the order total is greater than it was when
			-- it was last manually released (except for rules A and B).
			if (@CreditRule not in ('A', 'B'))
				if (@CreditHold = 1)
					if (@UnshippedBalance <= @ReleaseValue)
						select @CreditHold = 0

			-- Don't hold if the order total is zero or less.
			if (@UnshippedBalance <= 0)
				select	@CreditHold = 0,
					@EventDescr = ''

			-- If the Credit hold status has changed, prepare to update.
			if (@CreditHold <> @CreditHoldOld)
			begin
				if (@CreditHold = 1)
					select	@CreditHoldDate = GetDate(),
						@EventType = 'CHLD'
				else
					select	@CreditHoldDate = '',
						@EventDescr = @MsgRelease,
						@EventType = 'CREL'

				-- Update the sales order header.
				update	SOHeader
				set	CreditHold = @CreditHold,
					CreditHoldDate = @CreditHoldDate,
					ReleaseValue = 0,
					LUpd_DateTime = GetDate(),
					LUpd_Prog = @ProgID,
					LUpd_User = @UserID
				where	CpnyID = @CpnyID
				and	OrdNbr = @OrdNbr

				-- Post to the SO event log.
				exec ADG_SOEvent_Create @CpnyID, @EventDescr, @EventType, @OrdNbr, @ProgID, '', @UserID

				-- If the event is a credit release
				if @EventType = 'CREL'
				begin
					-- Insert a record into the work table so process manager knows which
					-- orders to auto advance
					insert into SO40400_CrRel_Wrk
						(AutoAdvanceDone,CpnyID,OrdNbr,
						S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
						S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,
						ShipperID)
					values	(0,@CpnyID, @OrdNbr,
						'','',0,0,0,0,
						0,0,0,0,'','',
						'')
				end
			end
		end
			fetch next from	SOHCursor
		into	@CpnyID,
			@CreditApprDays,
			@CreditApprLimit,
			@CreditHoldOld,
			@OrdNbr,
			@UnshippedBalance,
			@ReleaseValue,
			@COD
	end

	deallocate	SOHCursor

	declare		SOShCursor		cursor
	for select	sh.CpnyID,
			sh.CreditApprDays,
			sh.CreditApprLimit,
			sh.CreditHold,
			sh.OrdNbr,
			sh.ShipperID,
			sh.TotInvc,
			sh.ReleaseValue,
			t.COD
	from		SOShipHeader sh
	  join		Terms t on t.TermsID = sh.TermsID
	where		sh.CpnyID = @CpnyID
	  and		sh.CustID = @CustID
	  and		sh.Status = 'O'
	  and		sh.CreditChk = 1

	open		SOShCursor

	fetch next from	SOShCursor
	into	@CpnyID,
		@CreditApprDays,
		@CreditApprLimit,
		@CreditHoldOld,
		@OrdNbr,
		@ShipperID,
		@TotInvc,
		@ReleaseValue,
		@COD

	-- Loop through shippers.
	while (@@fetch_status <> -1)
	begin
		if (@@fetch_status = 0)
		begin
			select	@CreditHold = 0,
				@EventDescr = ''

			-- Set the credit hold status based on the credit rule.
			if (@CreditRule in ('A', 'B'))
				if (@OpenBal > @CreditApprLimit)
					select	@CreditHold = 1,
						@EventDescr = @MsgLimit

			if (@CreditRule = 'B')
				if (@CreditHold <> 1)
					if (@DaysPastDue > @CreditApprDays)
						select	@CreditHold = 1,
							@EventDescr = @MsgPastDue

			if (@CreditRule = 'C')
				if (@COD <> 1)
					select	@CreditHold = 1,
						@EventDescr = @MsgCOD

			if (@CreditRule = 'X')
				select	@CreditHold = 1,
					@EventDescr = @MsgDontSell

			if (@CreditRule not in ('A', 'B', 'C', 'N', 'X'))
				select	@CreditHold = 1,
					@EventDescr = @MsgHeld

			-- Don't hold unless the shipper total is greater than it was when
			-- it was last manually released (except for rules A and B).
			if (@CreditRule not in ('A', 'B'))
				if (@CreditHold = 1)
					if (@TotInvc <= @ReleaseValue)
						select @CreditHold = 0

			-- Don't hold if the shipper total is zero or less.
			if (@TotInvc <= 0)
				select	@CreditHold = 0,
					@EventDescr = ''

			-- If the Credit hold status has changed, prepare to update.
			if (@CreditHold <> @CreditHoldOld)
			begin
				if (@CreditHold = 1)
					select @CreditHoldDate = GetDate(),
						@EventType = 'CHLD'
				else
					select	@CreditHoldDate = '',
						@EventDescr = @MsgRelease,
						@EventType = 'CREL'

				-- Update the shipper header.
				update	SOShipHeader
				set	CreditHold = @CreditHold,
					CreditHoldDate = @CreditHoldDate,
					ReleaseValue = 0,
					LUpd_DateTime = GetDate(),
					LUpd_Prog = @ProgID,
					LUpd_User = @UserID
				where	CpnyID = @CpnyID
				and	ShipperID = @ShipperID

				-- Post to the SO event log.
				exec ADG_SOEvent_Create @CpnyID, @EventDescr, @EventType, @OrdNbr, @ProgID, @ShipperID, @UserID

				-- If the event is a credit release
				if @EventType = 'CREL'
				begin
					-- Insert a record into the work table so process manager knows which
					-- shippers to auto advance
					insert into SO40400_CrRel_Wrk
						(AutoAdvanceDone,CpnyID,OrdNbr,
						S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,
						S4Future07,S4Future08,S4Future09,S4Future10,S4Future11,S4Future12,
						ShipperID)
					values	(0,@CpnyID,'',
						'','',0,0,0,0,
						0,0,0,0,'','',
						@ShipperID)
				end
			end
		end
			fetch next from	SOShCursor
		into	@CpnyID,
			@CreditApprDays,
			@CreditApprLimit,
			@CreditHoldOld,
			@OrdNbr,
			@ShipperID,
			@TotInvc,
			@ReleaseValue,
			@COD
	end

	deallocate	SOShCursor


