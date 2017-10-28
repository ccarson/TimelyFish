 create proc ADG_Plan_UpdtInvtOrderQtysOrig
	@InvtID		varchar(30),
	@SiteID		varchar(10)
as
	set nocount on

	-- SOPlan cursor
	declare	@CpnyID		varchar(10)
	declare	@PlanType	varchar(2)
	declare	@PlanQty	float
	declare	@ReqPickDate	smalldatetime
	declare	@ShipperID	varchar(15)
	declare	@LineRef	varchar(5)

	-- SOShipLot cursor
	declare	@CnvFact	float
	declare	@LotSerNbr	varchar(25)
	declare	@ShipQty	float
	declare	@UnitMultDiv	varchar(1)
	declare	@WhseLoc	varchar(10)

	-- Other variables
	declare	@AllocDate	smalldatetime
	declare	@ErrorCode	smallint
	declare @LotSerTrack	varchar(2)
	declare	@QtyAlloc	float
	declare	@QtyCustOrd	float
	declare	@QtyOnBO	float
	declare	@QtyOnKitAssy	float
	declare	@QtyOnTransfer	float
	declare	@QtyPrec	smallint
	declare	@SerAssign	varchar(1)
	declare @StkItem	smallint

	-- Fetch information from Inventory.
	select	@LotSerTrack = LotSerTrack,
		@SerAssign = SerAssign,
		@StkItem = StkItem
	from	Inventory
	where	InvtID = @InvtID

	-- Exit if the item is not a stock item.
	-- This is a failsafe; this condition shouldn't happen.
	if (@StkItem <> 1)
		return

	-- Get the quantity precision.
	select @QtyPrec = (select DecPlQty from INSetup)

	-- Initialization
	select	@AllocDate = GetDate()
	select	@ErrorCode = 0
	select	@QtyAlloc = 0
	select	@QtyCustOrd = 0
	select	@QtyOnBO = 0

	-- Clear Location.QtyAlloc.
	update	Location
	set	QtyAlloc = 0
	where	InvtID = @InvtID
	and	SiteID = @SiteID

	-- Clear LotSerMst.QtyAlloc.
	if ((@LotSerTrack = 'LI') or (@LotSerTrack = 'SI'))
		update	LotSerMst
		set	QtyAlloc = 0
		where	InvtID = @InvtID
		and	SiteID = @SiteID

	declare	PlanCursor	cursor
	for
	select	CpnyID,
		PlanType,
		-Qty,		-- Qty inverted on SOPlan
		SOReqPickDate,
		SOShipperID,
		SOShipperLineRef

	from	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('30', '32', '34', '50', '52', '60', '62', '64') -- Shipper, SO

	open	PlanCursor

	fetch next from PlanCursor
	into	@CpnyID,
		@PlanType,
		@PlanQty,
		@ReqPickDate,
		@ShipperID,
		@LineRef

	while (@@Fetch_Status <> -1)
	begin
		if (@@Fetch_Status = 0)
		begin
			-- Always update QtyCustOrd.
			select	@QtyCustOrd = round((@QtyCustOrd + @PlanQty), @QtyPrec)

			-- Update QtyOnBO only for backordered sales order schedules.
			if (@PlanType in ('50', '52', '60', '62', '64'))	-- SO
				if (@ReqPickDate < @AllocDate)
					select	@QtyOnBO = round((@QtyOnBO + @PlanQty), @QtyPrec)

			-- Update QtyAlloc for shippers.
			if (@PlanType in ('30', '32', '34'))	-- Shipper
			begin
				-- Loop through SOShipLot.
				declare	ShipLotCursor	cursor
				for
				select	l.CnvFact,
					t.LotSerNbr,
					t.QtyShip,
					l.UnitMultDiv,
					t.WhseLoc

				from	SOShipLot t

				join	SOShipLine l
				on	l.CpnyID = t.CpnyID
				and	l.ShipperID = t.ShipperID
				and	l.LineRef = t.LineRef

				where	t.CpnyID = @CpnyID
				and	t.ShipperID = @ShipperID
				and	t.LineRef = @LineRef

				open ShipLotCursor

				fetch next from ShipLotCursor
				into	@CnvFact,
					@LotSerNbr,
					@ShipQty,
					@UnitMultDiv,
					@WhseLoc

				while (@@Fetch_Status <> -1)
				begin
					if (@@Fetch_Status = 0)
					begin
						-- Convert the unit of measure.
						if (rtrim(@UnitMultDiv) = 'D')
						begin
							if (@CnvFact <> 0)
								select @ShipQty = round((@ShipQty / @CnvFact), @QtyPrec)
						end
						else
							select @ShipQty = round((@ShipQty * @CnvFact), @QtyPrec)

						-- Clear the lot/serial number if this isn't a
						-- lot- or serial-numbered item or if it isn't assigned at receipt.
						if (((@LotSerTrack = 'LI') or (@LotSerTrack = 'SI')) and (@SerAssign = 'R'))
							select	@LotSerNbr = rtrim(@LotSerNbr)
						else
							select	@LotSerNbr = ''

						-- Create the item records if they don't already exist.
						exec ADG_Invt_NewItem @InvtID, @SiteID, @WhseLoc, @LotSerNbr, 'PLAN', 'PLAN', @ErrorCode

						-- Bypass if an error occurred while creating item records.
						if ((@@Error <= 0) and (@ErrorCode = 0))
						begin
							-- Accumulate QtyAlloc for ItemSite.
							select	@QtyAlloc = @QtyAlloc + @ShipQty

							-- Update Location.
	 						update	Location
							set	QtyAlloc = round((QtyAlloc + @ShipQty), @QtyPrec),
								LUpd_DateTime = GetDate(),
								LUpd_Prog = 'PLAN',
								LUpd_User = 'PLAN'

							where	InvtID = @InvtID
							and	SiteID	= @SiteID
							and	WhseLoc = @WhseLoc

							-- Update LotSerMst.
							if (@LotSerNbr > '')
								update	LotSerMst
								set	QtyAlloc = round((QtyAlloc + @ShipQty), @QtyPrec),
									LUpd_DateTime = GetDate(),
									LUpd_Prog = 'PLAN',
									LUpd_User = 'PLAN'

								where	InvtID = @InvtID
								and	LotSerNbr = @LotSerNbr
								and	SiteID	= @SiteID
								and	WhseLoc = @WhseLoc
						end
					end
					fetch next from ShipLotCursor
					into	@CnvFact,
						@LotSerNbr,
						@ShipQty,
						@UnitMultDiv,
						@WhseLoc
				end

				deallocate ShipLotCursor
			end
		end

		fetch next from PlanCursor
		into	@CpnyID,
			@PlanType,
			@PlanQty,
			@ReqPickDate,
			@ShipperID,
			@LineRef
	end

	deallocate PlanCursor

	select	@QtyOnKitAssy = sum(Qty)
	from	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('25', '26')

	select	@QtyOnKitAssy = coalesce(@QtyOnKitAssy, 0)

	select	@QtyOnTransfer = sum(Qty)
	from	SOPlan
	where	InvtID = @InvtID
	and	SiteID = @SiteID
	and	PlanType in ('28', '29')

	select	@QtyOnTransfer = coalesce(@QtyOnTransfer, 0)

	-- Create the item records if they don't already exist.
	exec ADG_Invt_NewItem @InvtID, @SiteID, '', '', 'PLAN', 'PLAN', @ErrorCode

	-- Bypass if an error occurred while creating item records.
	if ((@@Error <= 0) and (@ErrorCode = 0))
	begin
		-- Update ItemSite
		-- The LUpd fields aren't set because they'll be set by
		-- ADG_Invt_CalcQtyAvail below.
		update	ItemSite

		set	AllocQty = @QtyAlloc,
			QtyAlloc = @QtyAlloc,
			QtyCustOrd = @QtyCustOrd,
			QtyOnBO = @QtyOnBO,
			QtyOnKitAssyOrders = @QtyOnKitAssy,
			QtyOnTransferOrders = @QtyOnTransfer

		where	InvtID = @InvtID
		and	SiteID = @SiteID

		-- Recalculate the quantity available
		exec ADG_Invt_CalcQtyAvail @InvtID, @SiteID, 'PLAN', 'PLAN'
	end


