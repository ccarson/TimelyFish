 create procedure DMG_PR_InventoryInventoryADGSelected
	@InvtID		varchar(30),
        @ClassId	varchar(6) OUTPUT,
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(24) OUTPUT,
	@Descr		varchar(60) OUTPUT,
	@DfltPOUnit	varchar(6) OUTPUT,
        @DfltSite	varchar(10) OUTPUT,
	@DfltWhseLoc	varchar(10) OUTPUT,
	@DirStdCost	decimal(25,9) OUTPUT,
	@InvtAcct	varchar(10) OUTPUT,
	@InvtSub	varchar(24) OUTPUT,
	@LotSerFxdTyp	varchar(1) OUTPUT,
	@LotSerIssMthd	varchar(1) OUTPUT,
	@LotSerTrack	varchar(2) OUTPUT,
	@SerAssign	varchar(1) OUTPUT,
	@ShelfLife	smallint OUTPUT,
	@StkItem	smallint OUTPUT,
        @StkUnit	varchar(6) OUTPUT,
	@Supplr1	varchar(15) OUTPUT,
	@Supplr2	varchar(15) OUTPUT,
	@SupplrItem1	varchar(20) OUTPUT,
	@SupplrItem2	varchar(20) OUTPUT,
	@TaxCat		varchar(10) OUTPUT,
	@TranStatusCode	varchar(2) OUTPUT,
	@ValMthd	varchar(1) OUTPUT,
	@WarrantyDays	smallint OUTPUT,
	@Weight		decimal(25,9) OUTPUT,
	@LinkSpecID	smallint OUTPUT
as
	select	@ClassId = ltrim(rtrim(ClassId)),
		@COGSAcct = ltrim(rtrim(COGSAcct)),
		@COGSSub = ltrim(rtrim(COGSSub)),
		@Descr = ltrim(rtrim(Descr)),
		@DfltPOUnit = ltrim(rtrim(DfltPOUnit)),
		@DfltSite = ltrim(rtrim(DfltSite)),
		@DfltWhseLoc = ltrim(rtrim(DfltWhseLoc)),
		@DirStdCost = DirStdCost,
		@InvtAcct = ltrim(rtrim(InvtAcct)),
		@InvtSub = ltrim(rtrim(InvtSub)),
		@LotSerFxdTyp = ltrim(rtrim(LotSerFxdTyp)),
		@LotSerIssMthd = ltrim(rtrim(LotSerIssMthd)),
		@LotSerTrack = ltrim(rtrim(LotSerTrack)),
		@SerAssign = ltrim(rtrim(SerAssign)),
		@ShelfLife = ShelfLife,
		@StkItem = StkItem,
		@StkUnit = ltrim(rtrim(StkUnit)),
		@Supplr1 = ltrim(rtrim(Supplr1)),
		@Supplr2 = ltrim(rtrim(Supplr2)),
		@SupplrItem1 = ltrim(rtrim(SupplrItem1)),
		@SupplrItem2 = ltrim(rtrim(SupplrItem2)),
		@TaxCat = ltrim(rtrim(TaxCat)),
		@TranStatusCode = ltrim(rtrim(TranStatusCode)),
		@ValMthd = ltrim(rtrim(ValMthd)),
		@WarrantyDays = WarrantyDays,
		@Weight = Weight,
		@LinkSpecID = LinkSpecID
	from	Inventory (NOLOCK)
	join	InventoryADG (NOLOCK) on InventoryADG.InvtID = Inventory.InvtID
	where	Inventory.InvtID = @InvtID
	and	(TranStatusCode = 'AC'
	or	TranStatusCode = 'NU')

	if @@ROWCOUNT = 0 begin
		set @ClassId = ''
		set @COGSAcct = ''
		set @COGSSub = ''
		set @Descr = ''
		set @DfltPOUnit = ''
		set @DfltSite = ''
		set @DfltWhseLoc = ''
		set @DirStdCost = 0
		set @InvtAcct = ''
		set @InvtSub = ''
		set @LotSerFxdTyp = ''
		set @LotSerIssMthd = ''
		set @LotSerTrack = ''
		set @SerAssign = ''
		set @ShelfLife = 0
		set @StkItem = 0
		set @StkUnit = ''
		set @Supplr1 = ''
		set @Supplr2 = ''
		set @SupplrItem1 = ''
		set @SupplrItem2 = ''
		set @TaxCat = ''
		set @TranStatusCode = ''
		set @ValMthd = ''
		set @WarrantyDays = 0
		set @Weight = 0
		set @LinkSpecID = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_InventoryInventoryADGSelected] TO [MSDSL]
    AS [dbo];

