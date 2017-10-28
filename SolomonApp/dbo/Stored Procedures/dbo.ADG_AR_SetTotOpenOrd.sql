 create proc ADG_AR_SetTotOpenOrd
	@CpnyID		char(10),	-- must be char
	@CustID		char(15),	-- must be char
	@ProgID		char(8),
	@UserID		char(10)
as
	declare	@DecPl		smallint
	declare	@TotOpenOrd	float
	declare	@TotOpenShip	float
	declare	@TotCloseShip	float
	declare @TotCloseShip1	float
	declare	@TotCloseShip2	float
	declare @TotCloseShip3	float

	-- Get the base currency precision.
	select	@DecPl = c.DecPl
	from	GLSetup s WITH(NOLOCK),
		Currncy c
	where	s.BaseCuryID = c.CuryID

	-- Get the total on open sales orders.
	select	@TotOpenOrd = sum(h.UnshippedBalance)
	from	SOHeader h WITH(NOLOCK)
	inner join SOType y WITH(NOLOCK)
	on	y.CpnyID = h.CpnyID
	and	y.SOTypeID = h.SOTypeID
	where	h.CustID = @CustID
	and	h.Status = 'O'
	and	y.Behavior not in ('Q', 'BL')
	and	h.CpnyID = @CpnyID

	-- Get the total on open shippers and total on close shippers for all doctypes.
	SELECT	@TotOpenShip = SUM(CASE WHEN Status = 'O'
                                    THEN BalDue
                                    ELSE 0 END),
	        @TotCloseShip = SUM(CASE WHEN Status = 'C' AND Cancelled = 0 AND ConsolInv <> 1
                                     THEN BalDue
                                     ELSE 0 END)
	  FROM	SOShipHeader WITH(NOLOCK)
	 WHERE	CustID = @CustID
	   AND	CpnyID = @CpnyID
	   AND	ShipRegisterId = ''

        SELECT  @TotCloseShip1 = sum(BalDue)
          FROM  SOShipHeader s WITH(NOLOCK)
         WHERE  exists (SELECT refnbr
                          FROM ARDoc d WITH(NOLOCK)
                         WHERE d.CustID = s.CustID AND	d.Rlsed = 0
                           AND d.CpnyID = s.CpnyID AND d.RefNbr = s.InvcNbr
                           AND d.BatNbr = s.ARBatNbr AND d.DocType not in ('AD','RA'))
           AND  s.CustID = @Custid
           AND  s.CpnyID = @Cpnyid
           AND  s.Status = 'C'
           AND  s.Cancelled = 0
           AND  s.ConsolInv <> 1

	If Not Exists(SELECT SetupID FROM  SOSetup WITH(NOLOCK) WHERE ConsolInv = 1)
	BEGIN
		SET @TotCloseShip2 = 0
		SET @TotCloseShip3 = 0
	END
	ELSE
	BEGIN
		-- Get the total on close shippers for Accrual Documents and Reverse Accrual Documents./*
		SELECT  @TotCloseShip2 = sum(BalDue)
		  FROM  SOShipHeader s WITH(NOLOCK)
		 WHERE  s.AccrShipRegisterID = ''
		   AND  s.CustID = @CustID
		   AND  s.CpnyID = @CpnyID
		   AND  s.Status = 'C'
		   AND  s.Cancelled = 0
		   AND  s.ConsolInv = 1

		SELECT  @TotCloseShip3 = sum(BalDue)
		  FROM  SOShipHeader s WITH(NOLOCK)
		 WHERE  exists (SELECT refnbr
		                  FROM ARDoc d WITH(NOLOCK)
		                 WHERE d.CustID = s.CustID
		                   AND d.CpnyID = s.CpnyID
		                   AND d.RefNbr = s.ShipperID
		                   AND d.Rlsed = 0
		                   AND d.DocType in ('AD','RA')
			)
		   AND  s.CustID = @CustID
		   AND  s.CpnyID = @CpnyID
		   AND  s.Status = 'C'
		   AND  s.Cancelled = 0
		   AND  s.ConsolInv = 1
	END

	-- Add the two totals.
	select @TotOpenOrd = round((coalesce(@TotOpenOrd, 0) + coalesce(@TotOpenShip, 0)), @DecPl)

	-- Round.
	select @TotCloseShip = round((coalesce(@TotCloseShip, 0) + coalesce(@TotCloseShip1,0) +
                                      coalesce(@TotCloseShip2, 0) + coalesce(@TotCloseShip3, 0)), @DecPl)

	if exists (select * from AR_Balances where CpnyID = @CpnyID and CustID = @CustID)
	begin
		-- Update the existing AR balance record.
		update	AR_Balances
		set	LUpd_DateTime = getdate(),
			LUpd_Prog = @ProgID,
			LUpd_User = @UserID,
			TotOpenOrd = @TotOpenOrd,
			TotShipped = @TotCloseShip
		where	CpnyID = @CpnyID
		and	CustID = @CustID
	end
	else
	begin
		-- Insert nonexistent AR balance record.
		insert AR_Balances
			(
			AccruedRevAgeBal00, AccruedRevAgeBal01, AccruedRevAgeBal02, AccruedRevAgeBal03, AccruedRevAgeBal04, AccruedRevBal,
			AgeBal00, AgeBal01, AgeBal02, AgeBal03, AgeBal04, AvgDayToPay,
			CpnyID, CrLmt, Crtd_DateTime, Crtd_Prog, Crtd_User,
			CurrBal, CuryID, CuryPromoBal, CustID, FutureBal,
			LastActDate, LastAgeDate, LastFinChrgDate, LastInvcDate, LastStmtBal00,
			LastStmtBal01, LastStmtBal02, LastStmtBal03, LastStmtBal04, LastStmtBegBal, LastStmtDate,
			LUpd_DateTime, LUpd_Prog, LUpd_User, NbrInvcPaid, NoteID,
			PaidInvcDays, PerNbr, PromoBal, S4Future01, S4Future02,
			S4Future03, S4Future04, S4Future05, S4Future06, S4Future07,
			S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
			TotOpenOrd, TotPrePay, TotShipped, User1, User2, User3,
			User4, User5, User6, User7, User8
			)

		select distinct
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0,
			@CpnyID, 0, getdate(), @ProgID, @UserID,
			0, '', 0, @CustID, 0,
			'', '', '', '', 0,
			0, 0, 0, 0, 0, '',
			getdate(), @ProgID, @UserID, 0, 0,
			0, PerNbr, 0, '', '',
			0, 0, 0, 0, '',
			'', 0, 0, '', '',
			@TotOpenOrd, 0, @TotCloseShip, '', '', 0,
			0, '', '', '', ''
			from	Customer
		where	CustID = @CustID
	end


