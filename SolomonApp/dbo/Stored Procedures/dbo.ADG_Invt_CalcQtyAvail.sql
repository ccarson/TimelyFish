 create proc ADG_Invt_CalcQtyAvail
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@ProgID		varchar(8),
	@UserID		varchar(10)
as
	set nocount on

	declare		@InclQtyAlloc		smallint
	declare		@InclQtyCustOrd		smallint
	declare		@InclQtyInTransit	smallint
	declare		@InclQtyOnBO		smallint
	declare		@InclQtyOnPO		smallint
	declare		@InclQtyOnWO		smallint
	declare		@InclWOFirmDemand	smallint
	declare		@InclWOFirmSupply	smallint
	declare		@InclWORlsedDemand	smallint
	declare		@InclWORlsedSupply	smallint

	declare		@QtyAlloc		float
	declare		@QtyAvail		float
	declare		@QtyCustOrd		float
	declare		@QtyInTransit		float
	declare		@QtyNotAvail		float
	declare		@QtyOnBO		float
	declare		@QtyOnHand		float
	declare		@QtyOnKitAssyOrders	float
	declare		@QtyOnPO		float
	declare		@QtyOnTransferOrders	float
	declare		@QtyAllocBM		float
	declare		@QtyAllocIN		float
	declare		@QtyAllocPORet		float
	declare		@QtyAllocSD		float
	declare		@QtyShipNotInv		float
	declare		@QtyWOFirmDemand	float
	declare		@QtyWOFirmSupply	float
	declare		@QtyWORlsedDemand	float
	declare		@QtyWORlsedSupply	float
	DECLARE     @PCInstalled CHAR(1)
	DECLARE	    @QtyAllocProjIN float
	DECLARE     @PrjINQtyAlloc float
	DECLARE     @PrjINQtyCustOrd float
	DECLARE     @PrjINQtyShipNotInv float
	DECLARE     @PrjINQtyAllocIN float
	DECLARE     @PrjINQtyAllocPORet float


	declare		@QtyPrec		smallint
	declare		@StkItem		smallint

	-- Exit if the item is not a stock item.
	select @StkItem = (select StkItem from Inventory (NOLOCK) where InvtID = @InvtID)

	if (@StkItem = 0)
		return

	-- Get the 'include quantity?' parameters from INSetup.
	select		@QtyPrec = DecPlQty,
			@InclQtyAlloc = InclAllocQty,
			@InclQtyCustOrd = InclQtyCustOrd,
			@InclQtyInTransit = InclQtyInTransit,
			@InclQtyOnBO = InclQtyOnBO,
			@InclQtyOnPO = InclQtyOnPO,
			@InclQtyOnWO = InclQtyOnWO,
			@InclWOFirmDemand = InclWOFirmDemand,
			@InclWOFirmSupply = InclWOFirmSupply,
			@InclWORlsedDemand = InclWORlsedDemand,
			@InclWORlsedSupply = InclWORlsedSupply

	from		INSetup (NOLOCK)

	-- Get the current inventory quantities from ItemSite.
	select		@QtyAlloc = QtyAlloc,
			@QtyCustOrd = QtyCustOrd,
			@QtyInTransit = QtyInTransit,
			@QtyNotAvail = QtyNotAvail,
			@QtyOnBO = QtyOnBO,
			@QtyOnHand = QtyOnHand,
			@QtyOnKitAssyOrders = QtyOnKitAssyOrders,
			@QtyOnPO = QtyOnPO,
			@QtyOnTransferOrders = QtyOnTransferOrders,
			@QtyAllocBM = QtyAllocBM,
			@QtyAllocIN = QtyAllocIN,
			@QtyAllocPORet = QtyAllocPORet,
			@QtyAllocSD = QtyAllocSD,
			@QtyShipNotInv = QtyShipNotInv,
			@QtyWOFirmDemand = QtyWOFirmDemand,
			@QtyWOFirmSupply = QtyWOFirmSupply,
			@QtyWORlsedDemand = QtyWORlsedDemand,
			@QtyWORlsedSupply = QtyWORlsedSupply,
			@QtyAllocProjIN = QtyAllocProjIN,
			@PrjINQtyAlloc = PrjINQtyAlloc,
			@PrjINQtyCustOrd = PrjINQtyCustOrd,
			@PrjINQtyShipNotInv = PrjINQtyShipNotInv,
			@PrjINQtyAllocIN = PrjINQtyAllocIN,
			@PrjINQtyAllocPORet = PrjINQtyAllocPORet

	from		ItemSite
	where		InvtID = @InvtID
	  and		SiteID = @SiteID

	-- Calculate the quantity available.
	select		@QtyAvail = @QtyOnHand - @QtyNotAvail - @QtyAllocBM - @QtyAllocIN - @QtyAllocPORet - @QtyAllocSD - @QtyShipNotInv - @QtyAllocProjIN + @PrjINQtyShipNotInv + @PrjINQtyAllocIN + @PrjINQtyAllocPORet

	-- Supply
	if (@InclQtyInTransit = 1)
		select	@QtyAvail = @QtyAvail + @QtyInTransit + @QtyOnTransferOrders

	if (@InclQtyOnPO = 1)
		select	@QtyAvail = @QtyAvail + @QtyOnPO

	if (@InclQtyOnWO = 1)
		select	@QtyAvail = @QtyAvail + @QtyOnKitAssyOrders

	if (@InclWOFirmSupply = 1)
		select	@QtyAvail = @QtyAvail + @QtyWOFirmSupply

	if (@InclWORlsedSupply = 1)
		select	@QtyAvail = @QtyAvail + @QtyWORlsedSupply

	-- Demand
	if (@InclQtyCustOrd = 1)
		select	@QtyAvail = @QtyAvail - @QtyCustOrd + @PrjINQtyCustOrd
	else
	begin
		if (@InclQtyOnBO = 1)
			select	@QtyAvail = @QtyAvail - @QtyOnBO

		if (@InclQtyAlloc = 1)
			select	@QtyAvail = @QtyAvail - @QtyAlloc + @PrjINQtyAlloc
	end

	if (@InclWOFirmDemand = 1)
		select	@QtyAvail = @QtyAvail - @QtyWOFirmDemand

	if (@InclWORlsedDemand = 1)
		select	@QtyAvail = @QtyAvail - @QtyWORlsedDemand

	-- Round to the correct precision
	select @QtyAvail = round(@QtyAvail, @QtyPrec)

	-- Update the quantity available.
	update	ItemSite
	set	QtyAvail = @QtyAvail,
		LUpd_DateTime = GetDate(),
		LUpd_Prog = @ProgID,
		LUpd_User = @UserID
	where	InvtID = @InvtID
	  and	SiteID = @SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


