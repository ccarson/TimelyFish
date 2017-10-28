 create procedure ADG_Book_Shipper
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	
	declare @Behavior		varchar(4)
	declare @BookCntr 		smallint
	declare @BookingLimit		smallint
	declare @BookNewCnt		smallint
	declare @BookOldCnt		smallint
	declare	@CpnyIDBook		varchar(10)
	declare	@CurrPerNbr		varchar(6)
	declare @DecPlaces		smallint
	declare @Differences 		smallint
	declare @EffDateBook		smalldatetime
	declare @EffPeriod		varchar(6)
	declare @InnerCnt		smallint
	declare @OuterCnt		smallint
	declare @PctRnd			smallint
	declare @PostBookings		smallint
	declare @ShiptoType		varchar(1)
	declare @ShipLineRef		varchar(5)
	declare @SlsPerID		varchar(10)
	declare	@TodaysDate		smalldatetime
	declare @TotMerch		float
	declare @WholeOrdDiscAmt	float
	declare @WholeOrdDiscPct	float
	
	set nocount on
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
		@BookCntr = SOShipHeader.BookCntr,
		@ShiptoType = SOShipHeader.ShiptoType,
		@TotMerch = SOShipHeader.TotMerch,
		@WholeOrdDiscAmt = SOShipHeader.WholeOrdDisc,
		@WholeOrdDiscPct = SOShipHeader.DiscPct
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
	select
		ActionFlag = 'N', BookCntr = SOShipHeader.BookCntr, BookCommCost = SOShipLine.TotCommCost, BookCost = SOShipLine.TotCost, BookSls = SOShipLine.TotInvc,
		'', CommCost = SOShipLine.CommCost, 0, CommStmntID = '', ContractNbr = SOShipHeader.ContractNbr,
		Cost = SOShipLine.Cost, CpnyID = SOShipHeader.CpnyID, CreditPct = 0, '', SOShipHeader.Crtd_Prog,
		SOShipHeader.Crtd_User, SOShipHeader.CuryEffDate, SOShipHeader.CuryID, SOShipHeader.CuryMultDiv, SOShipHeader.CuryRate,
		SOShipHeader.CuryRateType, '', '', SOShipHeader.CustID, '',
		SOShipLine.DiscPct, '', '', 0, SOShipLine.InvtID,
		'', '', 0, '', SOShipHeader.OrdNbr,
		'', '', SOShipLine.ProjectID, QtyOrd = SOShipLine.QtyShip, SOShipHeader.Crtd_DateTime,
		S4Future01 = '', S4Future02 = '', S4Future03 = 0, S4Future04 = 0, S4Future05 = 0,
		S4Future06 = case when SOShipLineSplit.CreditPct is null then 0 else SOShipLineSplit.CreditPct end, S4Future07 = '', S4Future08 = '', S4Future09 = 0, S4Future10 = 0,
		S4Future11 = 'S', S4Future12 = '', '', SOShipHeader.ShipCustID, SOShipLine.LineRef,
		SOShipHeader.ShipperID, SOShipHeader.ShiptoID, SOShipHeader.SiteID, case when SOShipLineSplit.SlsPerID is null then '' else SOShipLineSplit.SlsPerID end, SOShipLine.SlsPrice,
		'', SOShipLine.TaskID, SOShipLine.UnitDesc, SOShipLine.UnitMultDiv, '',
		'', '', '', '', 0,
		0, '', '', '', 0,
		0, 0, null
	from	SOShipLine
	join	SOShipHeader
	on	SOShipHeader.CpnyID = SOShipLine.CpnyID
	and	SOShipHeader.ShipperID = SOShipLine.ShipperID
	left join SOShipLineSplit
	on	SOShipLineSplit.CpnyID = SOShipHeader.CpnyID
	and	SOShipLineSplit.LineRef = SOShipLine.LineRef
	and	SOShipLineSplit.ShipperID = SOShipHeader.ShipperID
	where	SOShipHeader.CpnyID = @CpnyID
	and	SOShipHeader.ShipperID = @ShipperID

	-- If the behavior is a credit or debit memo
	if @Behavior = 'CM' or @Behavior = 'DM'
	begin
		update	BookTempNew
		set	BookCommCost = 0,
			BookCost = 0,
			CommCost = 0,
			Cost = 0,
			S4Future04 = 0,
			S4Future05 = 0,
			QtyOrd = 0
	end

	-- Recalculate the BookSls if there is a Whole Order Discount
	if @WholeOrdDiscAmt <> 0
	begin
		update	BookTempNew
		set	BookSls = round(BookSls * (1 - (@WholeOrdDiscPct / 100)), @DecPlaces)

		-- Recalculate the highest BookSls value as the Whole Order Discount amount minus the other
		-- BookSls values so the total of all of them will always add up to the Whole Order Discount amount
		update	BookTempNew
		set	BookSls = @TotMerch - @WholeOrdDiscAmt - ((select sum(BookSls) from BookTempNew where SlsPerID = b1.SlsPerID) - (select max(BookSls) from BookTempNew where SlsPerID = b1.SlsPerID))
		from	BookTempNew b1
		where	BookSls = (select max(BookSls) from BookTempNew where SlsPerID = b1.SlsPerID)
		and	ShipLineRef = (	select	min(ShipLineRef)
					from	BookTempNew
					where	SlsPerID = b1.SlsPerID
					and	BookSls = (select max(BookSls) from BookTempNew where SlsPerID = b1.SlsPerID))
	end

	-- Calculate the credit percentage
	update	BookTempNew
	set	CreditPct = (S4Future06 * 100) / (select sum(S4Future06) from BookTempNew where ShipLineRef = b1.ShipLineRef)
	from	BookTempNew b1
	where	b1.S4Future06 > 0

	-- Calculate the weighted amounts
	update	BookTempNew
	set	S4Future03 = round((BookSls * CreditPct) / 100, @DecPlaces),
		S4Future04 = round((BookCost * CreditPct) / 100, @DecPlaces),
		S4Future05 = round((BookCommCost * CreditPct) / 100, @DecPlaces)

	-- Recalculate the highest Weighted amounts as the total - the other weighted amounts so the total of all
	-- of them will always add up to the total sales

	declare BookCursor cursor for
	select	distinct ShipLineRef
	from	BookTempNew

	open BookCursor
	fetch next from BookCursor into @ShipLineRef

	while (@@fetch_status = 0)
	begin
		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	S4Future03 = (select max(S4Future03) from BookTempNew where ShipLineRef = @ShipLineRef)

		-- Zero the weighted amount and flag the record with the largest weighted amount for
		-- each group of records associated with one schedule
		update	BookTempNew
		set	S4Future10 = 1,
			S4Future03 = 0
		where	ShipLineRef = @ShipLineRef
		and	SlsPerID = @SlsPerID

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future10 = 0,
			S4Future03 = BookSls - (select sum(S4Future03) from BookTempNew where ShipLineRef = @ShipLineRef)
		where	S4Future10 = 1

		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	S4Future04 = (select max(S4Future04) from BookTempNew where ShipLineRef = @ShipLineRef)

		-- Zero the weighted amount and flag the record with the largest weighted amount for
		-- each group of records associated with one schedule
		update	BookTempNew
		set	S4Future10 = 1,
			S4Future04 = 0
		where	ShipLineRef = @ShipLineRef
		and	SlsPerID = @SlsPerID

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future10 = 0,
			S4Future04 = BookCost - (select sum(S4Future04) from BookTempNew where ShipLineRef = @ShipLineRef)
		where	S4Future10 = 1

		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	S4Future05 = (select max(S4Future05) from BookTempNew where ShipLineRef = @ShipLineRef)

		-- Zero the weighted amount and flag the record with the largest weighted amount for
		-- each group of records associated with one schedule
		update	BookTempNew
		set	S4Future10 = 1,
			S4Future05 = 0
		where	ShipLineRef = @ShipLineRef
		and	SlsPerID = @SlsPerID

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future10 = 0,
			S4Future05 = BookCommCost - (select sum(S4Future05) from BookTempNew where ShipLineRef = @ShipLineRef)
		where	S4Future10 = 1

		fetch next from BookCursor into @ShipLineRef
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
	and	Book.S4Future11 in ('S', '')

	-- Update the old Book record with the new ReqDate from the new
	-- Book record. This is to update the reversal entry with the new
	-- requested and effective dates.
	update	BookTempOld
	set	ReqDate = BookTempNew.ReqDate
	from	BookTempNew
	inner join BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.OrdNbr = BookTempOld.OrdNbr
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.OrdLineRef = BookTempOld.OrdLineRef
	and	BookTempNew.SchedRef = BookTempOld.SchedRef
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.ShipLineRef = BookTempOld.ShipLineRef
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag

	-- Get the count of the existing booking records
	select	@BookOldCnt = count(*)
	from	BookTempOld

	-- Get the count of the matches with an outer join
	select	@OuterCnt = count(*)
	from	BookTempNew
	full outer join BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.OrdNbr = BookTempOld.OrdNbr
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.OrdLineRef = BookTempOld.OrdLineRef
	and	BookTempNew.SchedRef = BookTempOld.SchedRef
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.ShipLineRef = BookTempOld.ShipLineRef
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag

	-- Get the count of the matches with an inner join
	select	@InnerCnt = count(*)
	from	BookTempNew
	inner join BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.OrdNbr = BookTempOld.OrdNbr
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.OrdLineRef = BookTempOld.OrdLineRef
	and	BookTempNew.SchedRef = BookTempOld.SchedRef
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.ShipLineRef = BookTempOld.ShipLineRef
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag

	-- Join the temporary tables via the key fields and select the count of any that have
	-- different data fields. The fields compared are the fields defined as meaning new
	-- booking records should be written if they change.
	select	@Differences = count(*)
	from	BookTempNew
	join	BookTempOld
	on	BookTempNew.CpnyID = BookTempOld.CpnyID
	and	BookTempNew.OrdNbr = BookTempOld.OrdNbr
	and	BookTempNew.BookCntr = BookTempOld.BookCntr
	and	BookTempNew.OrdLineRef = BookTempOld.OrdLineRef
	and	BookTempNew.SchedRef = BookTempOld.SchedRef
	and	BookTempNew.ShipperID = BookTempOld.ShipperID
	and	BookTempNew.ShipLineRef = BookTempOld.ShipLineRef
	and	BookTempNew.SlsPerID = BookTempOld.SlsPerID
	and	BookTempNew.ActionFlag = BookTempOld.ActionFlag
	where 	BookTempNew.BookCommCost <> BookTempOld.BookCommCost
	or	BookTempNew.BookCost <> BookTempOld.BookCost
	or	BookTempNew.BookSls <> BookTempOld.BookSls
	or	BookTempNew.CommCost <> BookTempOld.CommCost
	or	BookTempNew.ContractNbr <> BookTempOld.ContractNbr
	or	BookTempNew.Cost <> BookTempOld.Cost
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
			BookCommCost = (-BookCommCost),
			BookCost = (-BookCost),
			BookSls = (-BookSls),
			EffDate =
				case when dateadd(day, @BookingLimit, ReqDate) < @TodaysDate then
					@TodaysDate
				else
					case when dateadd(day, @BookingLimit, ReqDate) < convert(datetime, '01/01/1900') then
						convert(smalldatetime, '01/01/1900')
					else
						dateadd(day, @BookingLimit, ReqDate)
					end
				end,
			QtyOrd = (-QtyOrd),
			S4Future05 = (-S4Future05),
			S4Future04 = (-S4Future04),
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
		set	BookCntr = @BookCntr,
			Crtd_DateTime = @TodaysDate,
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
		set	BookCntr = @BookCntr,
			LUpd_DateTime = @TodaysDate
		where	CpnyID = @CpnyID
		and	ShipperID = @ShipperID
	end

	-- Make sure all of the records are cleared out of the Book temp tables
	truncate table BookTempNew
	truncate table BookTempOld


