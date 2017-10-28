 create procedure DMG_Book_Shipper_Misc
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	declare @Behavior		varchar(4)
	declare @BookCntr 		smallint
	declare @BookingLimit		smallint
	declare @BookNewCnt		smallint
	declare @BookOldCnt		smallint
	declare	@CpnyIDBook		varchar(10)
	declare @CurrPerNbr		varchar(6)
	declare @DecPlaces		smallint
	declare @Differences 		smallint
	declare @EffDateBook		smalldatetime
	declare @EffPeriod		varchar(6)
	declare @InnerCnt		smallint
	declare @OuterCnt		smallint
	declare @PctRnd			smallint
	declare @PostBookings		smallint
	declare @S4Future12		varchar(5)	-- MiscChrgRef
	declare @ShiptoType		varchar(1)
	declare @SlsPerID		varchar(10)
	declare	@TodaysDate		smalldatetime

	-- This procedure will use two temporary tables that are duplicates of the Book table. One will
	-- be populated with the potentional booking records generated from the shipper. The other will be populated
	-- with the current booking records from the Book table for the shipper. If the two resulting tables are
	-- not the same, then new booking records will be written.

	-- Get the Order Management settings
	select	@BookingLimit = (-BookingLimit),	-- Get the booking limit number of days
		@PostBookings = PostBookings		-- See if we should be posting bookings
	from	SOSetup (nolock)

	-- Exit if we should not be posting bookings
	if @PostBookings = 0
		return

	-- Get the behavior associated with the shipper as well as the
	-- current book counter and the customer id from the shipper
	select	@Behavior = SOType.Behavior,
		@BookCntr = SOShipHeader.S4Future03,
		@ShiptoType = SOShipHeader.ShiptoType
	from	SOType
	join	SOShipHeader
	on	SOShipHeader.CpnyID = SOType.CpnyID
	and	SOShipHeader.SOTypeID = SOType.SOTypeID
	where	SOShipHeader.CpnyID = @CpnyID
	and	SOShipHeader.ShipperID = @ShipperID

	if @Behavior in ('Q', 'SHIP', 'TR', 'WO')
		return

	-- Get today's date (without the time)
	select	@TodaysDate = cast(floor(cast(getdate() as float)) as smalldatetime)

	-- Round percentages to 2 places
	select	@PctRnd = 2

	-- Select the decimal places setting from the currency table
	select	@DecPlaces = DecPl
	from	Currncy
	where	CuryID in (select BaseCuryID from GLSetup (nolock))

	-- Select the current period number
	select	@CurrPerNbr = CurrPerNbr
	from	ARSetup (nolock)

	-- Make sure all of the records are cleared out of the Book temp tables
	truncate table BookTempNew
	truncate table BookTempOld

	-- Insert the potential booking records generated from the shipper into the temporary table
	insert	BookTempNew
		(ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
		ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
		Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
		Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
		CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
		DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
		ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
		Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
		ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
		SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
		User10, User2, User3, User4, User5,
		User6, User7, User8, User9, WeightedBookCommCost,
		WeightedBookCost, WeightedBookSls)
	select
		ActionFlag = 'N', BookCntr = SOShipHeader.S4Future03, BookCommCost = 0,	BookCost = 0, BookSls = SOShipMisc.MiscChrg,
		'', CommCost = 0, 0, CommStmntID = '', ContractNbr = SOShipHeader.ContractNbr,
		Cost = 0, CpnyID = SOShipHeader.CpnyID, CreditPct = 0, Crtd_DateTime = '', Crtd_Prog = SOShipHeader.Crtd_Prog,
		Crtd_User = SOShipHeader.Crtd_User, CuryEffDate = SOShipHeader.CuryEffDate, CuryID = SOShipHeader.CuryID, CuryMultDiv = SOShipHeader.CuryMultDiv, CuryRate = SOShipHeader.CuryRate,
		CuryRateType = SOShipHeader.CuryRateType, CustClassID = '', CustCommClassID = '', CustID = SOShipHeader.CustID, CustTerr = '',
		DiscPct = 0, EffDate = '', EffPeriod = '', 0, InvtID = '',
		ItemCommClassID = '', '', NoteID = 0, OrdLineRef = '', OrdNbr = SOShipHeader.OrdNbr,
		Period = '', ProdClassID = '', ProjectID = SOShipHeader.ProjectID, QtyOrd = 0, ReqDate = SOShipHeader.OrdDate,
		S4Future01 = '', S4Future02 = '', S4Future03 = 0, S4Future04 = 0, S4Future05 = 0,
		S4Future06 = case when SOShipSplit.CreditPct is null then 0 else SOShipSplit.CreditPct end, S4Future07 = '', S4Future08 = '', S4Future09 = 0, S4Future10 = 0,
		S4Future11 = 'M', S4Future12 = SOShipMisc.MiscChrgRef, SchedRef = 'M', ShipCustID = '', ShipLineRef = SOShipMisc.MiscChrgRef,
		ShipperID = SOShipHeader.ShipperID, ShiptoID = '', SiteID = '', SlsPerID = case when SOShipSplit.SlsPerID is null then '' else SOShipSplit.SlsPerID end, SlsPrice = 0,
		SlsTerr = '', TaskID = '', UnitDesc = '', UnitMultDiv = '', User1 = '',
		User10 = '', User2 = '', User3 = '', User4 = '', User5 = 0,
		User6 = 0, User7 = '', User8 = '', User9 = '', 0,
		0, 0
	from	SOShipMisc
	join	SOShipHeader
	on	SOShipHeader.CpnyID = SOShipMisc.CpnyID
	and	SOShipHeader.ShipperID = SOShipMisc.ShipperID
	left join SOShipSplit
	on	SOShipSplit.CpnyID = SOShipHeader.CpnyID
	and	SOShipSplit.ShipperID = SOShipHeader.ShipperID
	where	SOShipHeader.CpnyID = @CpnyID
	and	SOShipHeader.ShipperID = @ShipperID

	-- Calculate the credit percentage
	update	BookTempNew
	set	CreditPct = (S4Future06 * 100) / (select sum(S4Future06) from BookTempNew where S4Future12 = b1.S4Future12)
	from	BookTempNew b1
	where	b1.S4Future06 > 0

	-- Calculate the weighted amounts
	update	BookTempNew
	set	S4Future03 = round((BookSls * CreditPct) / 100, @DecPlaces)

	-- Recalculate the highest Weighted amounts as the total - the other weighted amounts so the total of all
	-- of them will always add up to the total sales

	declare BookCursor cursor for
	select	distinct S4Future12
	from	BookTempNew

	open BookCursor
	fetch next from BookCursor into @S4Future12

	while (@@fetch_status = 0)
	begin
		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	S4Future03 = (select max(S4Future03) from BookTempNew where S4Future12 = @S4Future12)

		-- Zero the weighted amount and flag the record with the largest weighted amount for
		-- each group of records associated with one schedule
		update	BookTempNew
		set	S4Future10 = 1,
			S4Future03 = 0
		where	S4Future12 = @S4Future12 and SlsPerID = @SlsPerID

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future10 = 0,
			S4Future03 = BookSls - (select sum(S4Future03) from BookTempNew where S4Future12 = @S4Future12)
		where	S4Future10 = 1

		fetch next from BookCursor into @S4Future12
	end

	close BookCursor
	deallocate BookCursor

	-- Get the count of the potential new booking records
	select	@BookNewCnt = count(*)
	from	BookTempNew

	-- Insert the existing booking records from the book table for the shipper
	insert	BookTempOld
		(ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
		ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
		Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
		Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
		CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
		DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
		ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
		Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
		ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
		SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
		User10, User2, User3, User4, User5,
		User6, User7, User8, User9, WeightedBookCommCost,
		WeightedBookCost, WeightedBookSls)
	select
		ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
		ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
		Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
		Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
		CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
		DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
		ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
		Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
		S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
		ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
		SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
		User10, User2, User3, User4, User5,
		User6, User7, User8, User9, WeightedBookCommCost,
		WeightedBookCost, WeightedBookSls
	from	Book
	where	Book.CpnyID = @CpnyID
	and	Book.ShipperID = @ShipperID
	and	Book.BookCntr = @BookCntr
	and	Book.ActionFlag = 'N'
	and	Book.S4Future11 = 'M'

	-- Get the count of the existing booking records
	select	@BookOldCnt = count(*)
	from	BookTempOld

	-- Get the count of the matches with an outer join
	select	@OuterCnt = count(*)
	from	BookTempNew
	full outer join BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.S4Future12 = BookTempOld.S4Future12
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag

	-- Get the count of the matches with an inner join
	select	@InnerCnt = count(*)
	from	BookTempNew
	inner join BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.S4Future12 = BookTempOld.S4Future12
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag

	-- Join the temporary tables via the key fields and select the count of any that have
	-- different data fields. The fields compared are the fields defined as meaning new
	-- booking records should be written if they change.
	select	@Differences = count(*)
	from	BookTempNew
	join	BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.S4Future12 = BookTempOld.S4Future12
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag
	where 	BookTempNew.BookSls <> BookTempOld.BookSls
	or	BookTempNew.ContractNbr <> BookTempOld.ContractNbr
	or	BookTempNew.CreditPct <> BookTempOld.CreditPct
	or	BookTempNew.CuryEffDate <> BookTempOld.CuryEffDate
	or	BookTempNew.CuryID <> BookTempOld.CuryID
	or	BookTempNew.CuryMultDiv <> BookTempOld.CuryMultDiv
	or	BookTempNew.CuryRate <> BookTempOld.CuryRate
	or	BookTempNew.CuryRateType <> BookTempOld.CuryRateType
	or	BookTempNew.CustID <> BookTempOld.CustID
	or	BookTempNew.DiscPct <> BookTempOld.DiscPct
	or	BookTempNew.InvtID <> BookTempOld.InvtID
	or	BookTempNew.ProjectID <> BookTempOld.ProjectID
	or	BookTempNew.QtyOrd <> BookTempOld.QtyOrd
	or	BookTempNew.ReqDate <> BookTempOld.ReqDate
	or	BookTempNew.ShipCustID <> BookTempOld.ShipCustID
	or	BookTempNew.ShiptoID <> BookTempOld.ShiptoID
	or	BookTempNew.SiteID <> BookTempOld.SiteID
	or	BookTempNew.SlsPrice <> BookTempOld.SlsPrice
	or	BookTempNew.TaskID <> BookTempOld.TaskID
	or	BookTempNew.UnitDesc <> BookTempOld.UnitDesc
	or	BookTempNew.UnitMultDiv <> BookTempOld.UnitMultDiv

	-- If there are differences or either table has no records or the outer versus
	-- inner join counts are different (this means records are in one but not the
	-- other table) then redo the bookings
	if @Differences <> 0 or @BookNewCnt = 0 or @BookOldCnt = 0 or @OuterCnt <> @InnerCnt
	begin
		-- Update the existing book records to convert them to reversing entries
		update	BookTempOld
		set	ActionFlag = 'O',
			BookSls = (-BookSls),
			S4Future03 = (-S4Future03),
			Crtd_DateTime = @TodaysDate

		-- Add the reversing entry book records to the book table
		insert	Book
			(ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
			ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
			Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
			Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
			DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
			ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
			Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
			ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
			SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
			User10, User2, User3, User4, User5,
			User6, User7, User8, User9, WeightedBookCommCost,
			WeightedBookCost, WeightedBookSls)
		select
			ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
			ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
			Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
			Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
			DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
			ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
			Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
			ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
			SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
			User10, User2, User3, User4, User5,
			User6, User7, User8, User9, WeightedBookCommCost,
			WeightedBookCost, WeightedBookSls
		from	BookTempOld

		-- Increment the book counter
		select	@BookCntr = @BookCntr + 1

		-- Update the new booking records
		update	BookTempNew
		set	BookTempNew.BookCntr = @BookCntr,
			BookTempNew.Crtd_DateTime = @TodaysDate,
			CustClassID = isnull(C.ClassID, ''),
			CustCommClassID =
				case when @ShiptoType = 'C' then
					''
				else
					isnull(E.CustCommClassID, '')
				end,
			CustTerr = isnull(C.Territory, ''),
			EffDate =
				case when dateadd(day, @BookingLimit, convert(datetime, ReqDate)) < @TodaysDate then
					@TodaysDate
				else
					case when dateadd(day, @BookingLimit, convert(datetime, ReqDate)) < convert(datetime, '01/01/1900') then
						convert(smalldatetime, '01/01/1900')
					else
						convert(smalldatetime, dateadd(day, @BookingLimit, convert(datetime, ReqDate)))
					end
				end,
			ItemCommClassID = isnull(I.ItemCommClassID, ''),
			Period = @CurrPerNbr,
			ProdClassID = isnull(I.ClassID, ''),
			SlsTerr = coalesce((select Salesperson.Territory from Salesperson where Salesperson.SlsPerID = BookTempNew.SlsPerID), '')
		from	BookTempNew
		left join Customer C
		on	C.CustID = BookTempNew.CustID
		left join CustomerEDI E
		on	E.CustID = BookTempNew.CustID
		left join Inventory I
		on	I.InvtID = BookTempNew.InvtID

		-- Lookup the period based on the EffDate field and update each new booking record
		declare BookCursor cursor for
		select	CpnyID, EffDate
		from	BookTempNew

		open BookCursor
		fetch next from BookCursor into @CpnyIDBook, @EffDateBook

		while (@@fetch_status = 0)
		begin
			execute ADG_GLPeriod_GetPerFromDateOut @EffDateBook, 0, @EffPeriod output

			update	BookTempNew
			set	EffPeriod = @EffPeriod
			where current of BookCursor

			fetch next from BookCursor into @CpnyIDBook, @EffDateBook
		end

		close BookCursor
		deallocate BookCursor

		-- Add the new book records to the book table
		insert	Book
			(ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
			ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
			Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
			Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
			DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
			ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
			Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
			ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
			SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
			User10, User2, User3, User4, User5,
			User6, User7, User8, User9, WeightedBookCommCost,
			WeightedBookCost, WeightedBookSls)
		select
			ActionFlag, BookCntr, BookCommCost, BookCost, BookSls,
			ChargeType, CommCost, CommPct, CommStmntID, ContractNbr,
			Cost, CpnyID, CreditPct, Crtd_DateTime, Crtd_Prog,
			Crtd_User, CuryEffDate, CuryID, CuryMultDiv, CuryRate,
			CuryRateType, CustClassID, CustCommClassID, CustID, CustTerr,
			DiscPct, EffDate, EffPeriod, FirstRecord, InvtID,
			ItemCommClassID, MiscChrgRef, NoteID, OrdLineRef, OrdNbr,
			Period, ProdClassID, ProjectID, QtyOrd, ReqDate,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12, SchedRef, ShipCustID, ShipLineRef,
			ShipperID, ShiptoID, SiteID, SlsPerID, SlsPrice,
			SlsTerr, TaskID, UnitDesc, UnitMultDiv, User1,
			User10, User2, User3, User4, User5,
			User6, User7, User8, User9, WeightedBookCommCost,
			WeightedBookCost, WeightedBookSls
		from	BookTempNew

		-- Update the shipper to the new book counter
		update	SOShipHeader
		set	S4Future03 = @BookCntr,
			LUpd_DateTime = @TodaysDate
		where	CpnyID = @CpnyID
		and	ShipperID = @ShipperID
	end

	-- Make sure all of the records are cleared out of the Book temp tables
	truncate table BookTempNew
	truncate table BookTempOld


