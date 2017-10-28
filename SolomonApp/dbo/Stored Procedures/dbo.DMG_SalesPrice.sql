 create procedure DMG_SalesPrice
	@Behavior		varchar(4),
	@SiteID			varchar(10),
 	@QtyOrd			decimal(25,9),
	@UnitDesc		varchar(6),
	@CatalogNbr		varchar(15),
	@SlsPrcID		varchar(15),
	@CnvFact		decimal(25,9),
	@UnitMultDiv		varchar(1),
	@CustID			varchar(15),
	@InvtID			varchar(30),
	@CustPriceClassID	varchar(6),
	@InvtPriceClassID	varchar(6),
	@OrdDate		smalldatetime,
	@CuryID			varchar(4),
	@CuryRate		decimal(25,9),
	@CuryMultDiv		varchar(1),
	@CurySlsPrice		decimal(25,9) OUTPUT,
	@SlsPrice		decimal(25,9) OUTPUT,
	@DiscPct		decimal(25,9) OUTPUT,
	@ChainDisc		varchar(15) OUTPUT,
	@SlsPrcIDUsed		varchar(15) OUTPUT
As
	declare @AllowDiscPrice		bit
	declare @ChainDiscEnabled	bit
	declare @DecPlPrcCst		smallint
	declare @DecPlQty		smallint
	declare @DfltDiscountID		varchar(1)
	declare @DiscBySite		bit
	declare @DiscPrcSeq00		varchar(2)
	declare @DiscPrcSeq01   	varchar(2)
	declare @DiscPrcSeq02   	varchar(2)
	declare @DiscPrcSeq03   	varchar(2)
	declare @DiscPrcSeq04   	varchar(2)
	declare @DiscPrcSeq05   	varchar(2)
	declare @DiscPrcSeq06   	varchar(2)
	declare @DiscPrcSeq07   	varchar(2)
	declare @DiscPrcSeq08   	varchar(2)
	declare @PlanFound		bit
	declare @StkBasePrc		decimal(25,9)
	declare @TradeDisc		decimal(25,9)

	-- Pricing fields are zero on the following order type behaviors
	if @Behavior = 'SHIP' or @Behavior = 'TR' or @Behavior = 'WO'
	begin
		set @CurySlsPrice = 0
		set @SlsPrice = 0
		set @DiscPct = 0
		set @ChainDisc = ''
		set @SlsPrcIDUsed = ''
		return
	end

	-- Get the Rounding Precision values from INSetup
	select	@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
	from	INSetup (NOLOCK)

	-- Get information from SOSetup
	select	@AllowDiscPrice = AllowDiscPrice,
		@ChainDiscEnabled = ChainDiscEnabled,
		@DfltDiscountID = DfltDiscountID,
		@DiscBySite     = DiscBySite,
		@DiscPrcSeq00   = DiscPrcSeq00,
		@DiscPrcSeq01   = DiscPrcSeq01,
		@DiscPrcSeq02   = DiscPrcSeq02,
		@DiscPrcSeq03   = DiscPrcSeq03,
		@DiscPrcSeq04   = DiscPrcSeq04,
		@DiscPrcSeq05   = DiscPrcSeq05,
		@DiscPrcSeq06   = DiscPrcSeq06,
		@DiscPrcSeq07   = DiscPrcSeq07,
		@DiscPrcSeq08   = DiscPrcSeq08
	from	SOSetup (NOLOCK)

	-- Get the customers trade discount
	set	@TradeDisc = 0

	select	@TradeDisc = TradeDisc
	from	Customer (NOLOCK)
	where	CustID = @CustID
		-- If discount pricing is in effect
	if @AllowDiscPrice = 1
	begin
		exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq00, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
			@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
			@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID, @SlsPrcID,
			@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq01, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq02, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq03, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq04, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq05, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq06, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq07, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT

		if @PlanFound = 0
			exec @PlanFound = DMG_SalesPriceBySeq @DiscPrcSeq08, @CustID, @CustPriceClassID, @SiteID, @InvtID, @InvtPriceClassID,
				@CuryID, @QtyOrd, @UnitDesc, @CatalogNbr, @OrdDate, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv,
				@DecPlPrcCst, @DiscBySite, @TradeDisc, @ChainDiscEnabled, @DfltDiscountID,  @SlsPrcID,
				@CurySlsPrice OUTPUT, @SlsPrice OUTPUT, @DiscPct OUTPUT, @ChainDisc OUTPUT, @SlsPrcIDUsed OUTPUT
	end

	-- Do normal pricing if a price plan was not found or discount pricing is turned off
	if @PlanFound = 0 or @AllowDiscPrice = 0 begin
			exec DMG_ItemPrice @InvtID, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv, @CurySlsPrice OUTPUT, @SlsPrice OUTPUT

		-- Set the discount percent
		Set @DiscPct = @TradeDisc

		-- If chain discounts are enabled
		if @ChainDiscEnabled = 1
		begin
            		If @TradeDisc <> 0
				-- Casting it as a float gets rid of the trailing zeros, couldn't think of a better way to do it.
                		Set @ChainDisc = @DfltDiscountID + cast(cast(@TradeDisc as float) as varchar(10))
			else
				Set @ChainDisc = ''
		end

		-- No price plan was used
		Set @SlsPrcIDUsed = ''
	end

	--select @CurySlsPrice, @SlsPrice, @DiscPct, @ChainDisc, @SlsPrcIDUsed



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SalesPrice] TO [MSDSL]
    AS [dbo];

