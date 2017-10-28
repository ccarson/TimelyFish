 create procedure DMG_PR_LotSerMstSelected
	@InvtID		varchar(30),
	@LotSerNbr	varchar(25),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@MfgrLotSerNbr	varchar(25) OUTPUT,
	@QtyAlloc	decimal(25,9) OUTPUT,
	@QtyOnHand	decimal(25,9) OUTPUT,
	@QtyShipNotInv	decimal(25,9) OUTPUT,
	@QtyAvail	decimal(25,9) OUTPUT
as
	select	@MfgrLotSerNbr = ltrim(rtrim(MfgrLotSerNbr)),
		@QtyAlloc = QtyAlloc,
		@QtyOnHand = QtyOnHand,
		@QtyShipNotInv = QtyShipNotInv,
		@QtyAvail = QtyAvail
	from	LotSerMst (NOLOCK)
	where	InvtID = @InvtID
	and	LotSerNbr = @LotSerNbr
	and	SiteID = @SiteID
	and	WhseLoc = @WhseLoc

	if @@ROWCOUNT = 0 begin
		set @MfgrLotSerNbr = ''
		set @QtyAlloc = 0
		set @QtyOnHand = 0
		set @QtyShipNotInv = 0
		set @QtyAvail = 0
		return 0	--Failure
	end
	else
		return 1	--Success


