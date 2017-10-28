 create procedure DMG_InventoryInventoryADGSelected
	@InvtID		varchar(30),
        @ChkOrdQty	varchar(1) OUTPUT,
        @ClassId	varchar(6) OUTPUT,
        @Descr		varchar(60) OUTPUT,
        @DfltSite	varchar(10) OUTPUT,
        @DfltSOUnit	varchar(6) OUTPUT,
        @GLClassID	varchar(4) OUTPUT,
        @LastCost	decimal(25,9) OUTPUT,
        @ListPrice	decimal(25,9) OUTPUT,
	@LotSerIssMthd	varchar(1) OUTPUT,
        @LotSerTrack	varchar(2) OUTPUT,
        @MinGrossProfit	decimal(25,9) OUTPUT,
        @MinPrice	decimal(25,9) OUTPUT,
        @Pack		smallint OUTPUT,
	@PackCnvFact	decimal(25,9) OUTPUT,
        @PackMethod	varchar(2) OUTPUT,
        @PackSize	smallint OUTPUT,
	@PackUnitMultDiv varchar(1) OUTPUT,
        @PackUOM	varchar(6) OUTPUT,
        @PriceClassID	varchar(6) OUTPUT,
        @ProdLineID	varchar(4) OUTPUT,
        @SerAssign	varchar(1) OUTPUT,
	@ShelfLife	smallint OUTPUT,
        @StdCartonBreak	smallint OUTPUT,
        @StdCost	decimal(25,9) OUTPUT,
        @StkItem	smallint OUTPUT,
        @StkUnit	varchar(6) OUTPUT,
        @TaxCat		varchar(10) OUTPUT,
        @TranStatusCode	varchar(2) OUTPUT,
        @ValMthd	varchar(1) OUTPUT,
        @Weight		decimal(25,9) OUTPUT,
		@LinkSpecID	smallint OUTPUT
as
	declare @INInstalled smallint

	-- Get an indication if the Inventory module is installed
	select @INInstalled = count(*) from INSetup (NOLOCK) where Init = 1

	select	@ChkOrdQty = ltrim(rtrim(ChkOrdQty)),
		@ClassId = ltrim(rtrim(ClassId)),
		@Descr = ltrim(rtrim(Descr)),
		@DfltSite = ltrim(rtrim(DfltSite)),
		@DfltSOUnit = ltrim(rtrim(DfltSOUnit)),
		@GLClassID = ltrim(rtrim(GLClassID)),
		@LastCost = LastCost,
		@ListPrice = ListPrice,
		@LotSerIssMthd = ltrim(rtrim(LotSerIssMthd)),
		@LotSerTrack = ltrim(rtrim(LotSerTrack)),
		@MinGrossProfit = MinGrossProfit,
		@MinPrice = MinPrice,
		@Pack = InventoryADG.Pack,
		@PackCnvFact = InventoryADG.PackCnvFact,
		@PackMethod = ltrim(rtrim(PackMethod)),
		@PackSize = PackSize,
		@PackUnitMultDiv = ltrim(rtrim(InventoryADG.PackUnitMultDiv)),
		@PackUOM = ltrim(rtrim(PackUOM)),
		@PriceClassID = ltrim(rtrim(PriceClassID)),
		@ProdLineID = ltrim(rtrim(ProdLineID)),
		@SerAssign = ltrim(rtrim(SerAssign)),
		@ShelfLife = ShelfLife,
		@StdCartonBreak = StdCartonBreak,
		@StdCost = StdCost,
		@StkItem = StkItem,
		@StkUnit = ltrim(rtrim(StkUnit)),
		@TaxCat = ltrim(rtrim(TaxCat)),
		@TranStatusCode = ltrim(rtrim(TranStatusCode)),
		@ValMthd = ltrim(rtrim(ValMthd)),
		@Weight = Weight,
		@LinkSpecID = LinkSpecID
	from	Inventory (NOLOCK)
	join	InventoryADG (NOLOCK) on InventoryADG.InvtID = Inventory.InvtID
	where	Inventory.InvtID = @InvtID
	and	(TranStatusCode = 'AC'
	or	TranStatusCode = 'NP'
	or	TranStatusCode = 'OH' and @INInstalled <> 0)

	if @@ROWCOUNT = 0 begin
		set @ChkOrdQty = ''
		set @ClassId = ''
		set @Descr = ''
		set @DfltSite = ''
		set @DfltSOUnit = ''
		set @GLClassID = ''
		set @LastCost = 0
		set @ListPrice = 0
		set @LotSerIssMthd = ''
		set @LotSerTrack = ''
		set @MinGrossProfit = 0
		set @MinPrice = 0
		set @Pack = 0
		set @PackCnvFact = 0
		set @PackMethod = ''
		set @PackSize = 0
		set @PackUnitMultDiv = ''
		set @PackUOM = ''
		set @PriceClassID = ''
		set @ProdLineID = ''
		set @SerAssign = ''
		set @ShelfLife = 0
		set @StdCartonBreak = 0
		set @StdCost = 0
		set @StkItem = 0
		set @StkUnit = ''
		set @TaxCat = ''
		set @TranStatusCode = ''
		set @ValMthd = ''
		set @Weight = 0
		set @LinkSpecID = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_InventoryInventoryADGSelected] TO [MSDSL]
    AS [dbo];

