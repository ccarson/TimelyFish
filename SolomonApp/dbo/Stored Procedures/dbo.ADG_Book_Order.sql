 create procedure ADG_Book_Order
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
as

	
	declare @Behavior		varchar(4)
	declare @BookCntr 		smallint
	declare @BookingLimit		smallint
	declare @BookNewCnt		smallint
	declare @BookOldCnt		smallint
	declare @CpnyIDBook		varchar(10)
	declare	@CurrPerNbr		varchar(6)
	declare @DecPlaces		smallint
	declare @Differences 		smallint
	declare @EffDateBook		smalldatetime
	declare @EffPeriod		varchar(6)
	declare @InnerCnt		smallint
	declare @MaxBookSls		float
	declare @NewBookSls		float
	declare @OrdLineRef		varchar(5)
	declare @OuterCnt		smallint
	declare @PctRnd			smallint
	declare @PostBookings		smallint
	declare @SchedRef		varchar(5)
	declare @ShiptoType		varchar(1)
	declare @SlsPerID		varchar(10)
	declare	@TodaysDate		smalldatetime
	declare	@TotActQtyOrd		float
	declare @TotQtyOrd		float

	set nocount on
	-- This procedure will use two temporary tables that are duplicates of the Book table. One will
	-- be populated with the potentional booking records generated from the order. The other will be populated
	-- with the current booking records from the Book table for the order. If the two resulting tables are
	-- not the same, then new booking records will be written.

	-- Get the Order Management settings
	select	@BookingLimit = (-BookingLimit),	-- Get the booking limit number of days
		@PostBookings = PostBookings		-- See if we should be posting bookings
	from	SOSetup (nolock)

	-- Exit if we should not be posting bookings
	if @PostBookings = 0
		return

	-- Get the behavior associated with the order as well as the
	-- current book counter and the customer id from the order
	select	@Behavior = SOType.Behavior,
		@BookCntr = SOHeader.BookCntr,
		@ShiptoType = SOHeader.ShiptoType
	from	SOType
	join	SOHeader
	on	SOHeader.CpnyID = SOType.CpnyID
	and	SOHeader.SOTypeID = SOType.SOTypeID
	where	SOHeader.CpnyID = @CpnyID
	and	SOHeader.OrdNbr = @OrdNbr

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

	-- Insert the potential booking records generated from the order into the temporary table
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
	select	ActionFlag = 'N', BookCntr = SOHeader.BookCntr, BookCommCost = case when SOSched.Status = 'O' then round(cast(cast(SOLine.CommCost as decimal(30,9)) * SOSched.QtyOrd as decimal(30,9)), @DecPlaces) else round(cast(cast(SOLine.CommCost as decimal(30,9)) * SOSched.QtyShip as decimal(30,9)), @DecPlaces) end, BookCost = case when SOSched.Status = 'O' then round(cast(cast(SOLine.Cost as decimal(30,9)) * SOSched.QtyOrd as decimal(30,9)), @DecPlaces)
		else round(cast(cast(SOLine.Cost as decimal(30,9)) * SOSched.QtyShip as decimal(30,9)), @DecPlaces) end, BookSls = case when SOSched.Status = 'O' then round(cast(cast(SOLine.SlsPrice as decimal(30,9)) * SOSched.QtyOrd * (1 - (SOLine.DiscPct / 100)) as decimal(30,9)), @DecPlaces) else round(cast(cast(SOLine.SlsPrice as decimal(30,9)) * SOSched.QtyShip * (1 - (SOLine.DiscPct / 100)) as decimal(30,9)), @DecPlaces) end,
		'', CommCost = SOLine.CommCost, 0, CommStmntID = '',
		ContractNbr = SUBSTRING(SOHeader.ContractNbr,1,10), Cost = SOLine.Cost, CpnyID = SOHeader.CpnyID, CreditPct = 0, '', SOHeader.Crtd_Prog,
		SOHeader.Crtd_User, SOHeader.CuryEffDate, SOHeader.CuryID, SOHeader.CuryMultDiv, SOHeader.CuryRate,
		SOHeader.CuryRateType, '', '', SOHeader.CustID, '',
		SOLine.DiscPct, '', '', 0, SOLine.InvtID,
		'', '', 0, SOLine.LineRef, SOHeader.OrdNbr,
		'', '', SOLine.ProjectID, QtyOrd = case when SOSched.Status = 'O' then SOSched.QtyOrd else SOSched.QtyShip end, SOSched.ReqDate,
		S4Future01 = '', S4Future02 = '', S4Future03 = SOHeader.DiscPct, S4Future04 = 0, S4Future05 = 0,
		S4Future06 = case when SOSplitLine.CreditPct is null then 0 else SOSplitLine.CreditPct end, S4Future07 = '', S4Future08 = '', S4Future09 = 0, S4Future10 = 0,
		S4Future11 = 'S', S4Future12 = '', SOSched.SchedRef, SOSched.ShipCustID, '',
		'', SOSched.ShiptoID, SOSched.SiteID, case when SOSplitLine.SlsPerID is null then '' else SOSplitLine.SlsPerID end, SOLine.SlsPrice,
		'', SOLine.TaskID, SOLine.UnitDesc, SOLine.UnitMultDiv, '',
		'', '', '', '', 0,
		0, '', '', '', 0,
		0, 0
	from	SOSched
	join	SOHeader
	on	SOHeader.CpnyID = SOSched.CpnyID
	and	SOHeader.OrdNbr = SOSched.OrdNbr
	join	SOLine
	on	SOLine.CpnyID = SOSched.CpnyID
	and	SOLine.LineRef = SOSched.LineRef
	and	SOLine.OrdNbr = SOSched.OrdNbr
	left join SOSplitline
	on	SOSplitLine.CpnyID = SOHeader.CpnyID
	and	SOSplitLine.LineRef = SOLine.LineRef
	and	SOSplitLine.OrdNbr = SOHeader.OrdNbr
	where	SOHeader.CpnyID = @CpnyID
	and	SOHeader.OrdNbr = @OrdNbr

	-- Set the sales price to what's on the shipper's price
	IF @ShipperID <> ''
	BEGIN
	update	BookTempNew
	set	BookTempNew.SlsPrice = SOShipLine.SlsPrice,
		BookTempNew.BookSls = case when SOSched.Status = 'O'
                then round(cast(cast(SOShipLine.SlsPrice as decimal(30,9)) * BookTempNew.QtyOrd* (1 - (SOShipLine.DiscPct / 100)) as decimal(30,9)), @DecPlaces)
                else round(cast(cast(SOShipLine.SlsPrice as decimal(30,9)) * SOSched.QtyShip * (1 - (SOShipLine.DiscPct / 100)) as decimal(30,9)), @DecPlaces) end

	from	SOShipSched
	join SOSched
		on SOSched.CpnyID = SOShipSched.CpnyID
		and SOSched.OrdNbr = SOShipSched.OrdNbr
		and SOSched.LineRef = SOShipSched.OrdLineRef
		and sosched.SchedRef = SOShipSched.OrdSchedRef
	join BookTempNew
		on BookTempNew.CpnyID = SOShipSched.CpnyID
		and BookTempNew.OrdNbr = SOShipSched.OrdNbr
		and BookTempNew.OrdLineRef = SOShipSched.OrdLineRef
		and BookTempNew.SchedRef = soshipsched.OrdSchedRef
	join SOShipLine
		on SOShipLine.CpnyID = SOShipSched.CpnyID
		and SOShipLine.ShipperID = SOShipSched.ShipperID
		and SOShipLine.LineRef = SOShipSched.ShipperLineRef
	join SOShipHeader
		on SOShipHeader.CpnyID = SOShipSched.CpnyID
		and SOShipHeader.ShipperID = SOShipSched.ShipperID
	where SOShipSched.ShipperID = @ShipperID
		and SOShipSched.CpnyID = @CpnyID
		and SOShipSched.OrdNbr = @OrdNbr
		and SOShipHeader.Cancelled = 0
	END
	
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

	-- Calculate the total with the whole order discount from the shipper
	IF @ShipperID <> ''
	BEGIN
	update	BookTempNew
	set	BookTempNew.BookSls = round(BookSls * (1 - (sosh.DiscPct / 100)), @DecPlaces)
	from	SOShipSched soss
	join	SOShipHeader sosh
	on	sosh.CpnyID = soss.CpnyID
	and	sosh.ShipperID = soss.ShipperID
	and	sosh.OrdNbr = soss.OrdNbr
	where	BookTempNew.CpnyID = soss.CpnyID
	and	BookTempNew.OrdNbr = soss.OrdNbr
	and	BookTempNew.OrdLineRef = soss.OrdLineRef
	and	BookTempNew.SchedRef = soss.OrdSchedRef
	and sosh.ShipperID = @ShipperID
	and	sosh.Cancelled = 0
	END

	-- Calculate the credit percentage based on the salesperson pct per group of schedule lines
	update	BookTempNew
	set	CreditPct = (S4Future06 * 100) / (select sum(S4Future06) from BookTempNew where OrdLineRef = b1.OrdLineRef and SchedRef = b1.SchedRef)
	from	BookTempNew b1
	where	b1.S4Future06 > 0

	-- Calculate the weighted amounts
	update	BookTempNew
	set	S4Future03 = round((BookSls * CreditPct) / 100, @DecPlaces),
		S4Future04 = round((BookCost * CreditPct) / 100, @DecPlaces),
		S4Future05 = round((BookCommCost * CreditPct) / 100, @DecPlaces)

	-- Recalculate the highest weighted amounts as the total - the other weighted amounts so the total of all
	-- of them will always add up to the total sales
	declare BookCursor cursor for
	select	distinct OrdLineRef, SchedRef
	from	BookTempNew

	open BookCursor
	fetch next from BookCursor into @OrdLineRef, @SchedRef

	while (@@fetch_status = 0)
	begin
		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
                where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef
                ORDER BY S4Future03 Desc

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future03 = BookSls - ISNULL((SELECT sum(S4Future03)
						         FROM BookTempNew
						        WHERE OrdLineRef = @OrdLineRef AND SchedRef = @SchedRef
						          AND SlsPerID <> @SlsPerID),0)
		where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef and SlsPerID = @SlsPerID

		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef
                Order By S4Future04 Desc

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future04 = BookCost - ISNULL((SELECT sum(S4Future04)
                                                          FROM BookTempNew
                                                         WHERE OrdLineRef = @OrdLineRef AND SchedRef = @SchedRef
                                                           AND SlsPerID <> @SlsPerID),0)
		where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef and SlsPerID = @SlsPerID

		-- Get the SlsPerID of the record to adjust in case the weighted amounts are not unique
		select	top 1 @SlsPerID = SlsPerID
		from	BookTempNew
		where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef
                ORDER BY S4Future05 Desc

		-- Adjust the flagged record to be the BookSls amount less the other weighted amounts so the total of the
		-- records will always add up to the BookSls amount.
		update	BookTempNew
		set	S4Future05 = BookCommCost - ISNULL((SELECT sum(S4Future05)
                                                             FROM BookTempNew
                                                            WHERE OrdLineRef = @OrdLineRef AND SchedRef = @SchedRef
                                                              AND SlsPerID <> @SlsPerID),0)
		where	OrdLineRef = @OrdLineRef and SchedRef = @SchedRef and SlsPerID = @SlsPerID

		fetch next from BookCursor into @OrdLineRef, @SchedRef
	end

	close BookCursor
	deallocate BookCursor

	-- Get the count of the potential booking records
	select	@BookNewCnt = count(*)
	from	BookTempNew

	-- Insert the existing booking records from the book table for the order
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
		ChargeType, CommCost, CommPct, CommStmntID, SUBSTRING(ContractNbr,1,10),
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
	and	Book.OrdNbr = @OrdNbr
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
			Period =
				case when @CurrPerNbr > Period then
					@CurrPerNbr
				else
					Period
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

		-- Update the order to the new book counter
		update	SOHeader
		set	BookCntr = @BookCntr,
			LUpd_DateTime = @TodaysDate
		where	CpnyID = @CpnyID
		and	OrdNbr = @OrdNbr
	end

	-- Make sure all of the records are cleared out of the Book temp tables
	truncate table BookTempNew
	truncate table BookTempOld


