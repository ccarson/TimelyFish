 CREATE Procedure DMG_SalesPriceBySeq
	@PriceCat		varchar(2),
	@CustID     	  	varchar(15),
	@CustPriceClassID 	varchar(6),
	@SiteID     	  	varchar(10),
	@InvtID     	  	varchar(30),
	@InvtPriceClassID 	varchar(6),
	@CuryID           	varchar(4),
	@Quantity         	decimal(25,9),
	@SlsUnit          	varchar(6),
	@CatalogNbr       	varchar(15),
	@OrdDate		smalldatetime,
	@CnvFact		decimal(25,9),
	@UnitMultDiv		varchar(1),
	@CuryRate		decimal(25,9),
	@CuryMultDiv		varchar(1),
	@DecPlPrcCst		smallint,
	@DiscBySite		bit,
	@TradeDisc		decimal(25,9),
	@ChainDiscEnabled	bit,
	@DfltDiscountID		varchar(1),
	@SlsPrcID		varchar(15),
	@CurySlsPrice		decimal(25,9) OUTPUT,
	@SlsPrice		decimal(25,9) OUTPUT,
	@DiscPct		decimal(25,9) OUTPUT,
	@ChainDisc		varchar(15) OUTPUT,
	@SlsPrcIDUsed		varchar(15) OUTPUT

As
	declare @Cost			decimal(25,9)
	declare @CuryCost		decimal(25,9)
	declare @DiscountAmt		decimal(25,9)
	declare @DiscPercent		decimal(25,9)
	declare @DiscPrcMthd		varchar(1)
	declare @DiscPrcTyp		varchar(1)
	declare @DiscPrice		decimal(25,9)
	declare @EndDate		smalldatetime
	declare @MarkupAmt		decimal(25,9)
	declare @MarkupPercent		decimal(25,9)
	declare @RowCount		smallint
	declare @QtyBreak		decimal(25,9)
	declare @SelectFld1		varchar(30)
	declare @SelectFld2		varchar(30)
	declare @StartDate		smalldatetime

	if @PriceCat = 'CU' -- CUSTOMER
		select	@SelectFld1 = @CustID, @SelectFld2 = ''

	else if @PriceCat = 'CC' -- CUSTOMER PRICE CLASS
		select  @SelectFld1 = @CustPriceClassID, @SelectFld2 = ''

	else if @PriceCat = 'IT' -- INVENTORY ITEM
		select  @SelectFld1 = @InvtID, @SelectFld2 = ''

	else if @PriceCat = 'IL' -- INVENTORY ITEM AND CUST PRICE CLASS
		select  @SelectFld1 = @InvtID, @SelectFld2 = @CustPriceClassID

	else if @PriceCat = 'IC' -- INVENTORY ITEM AND CUSTOMER
		select  @SelectFld1 = @InvtID, @SelectFld2 = @CustID

	else if @PriceCat = 'PC' -- INvENTORY PRICE CLASS
		select  @SelectFld1 = @InvtPriceClassID, @SelectFld2 = ''

	else if @PriceCat = 'PL' -- Inventory PRICE CLASS AND CUST PRICE CLASS
		select  @SelectFld1 = @InvtPriceClassID, @SelectFld2 = @CustPriceClassID

	else if @PriceCat = 'LC' -- INVENTORY PRICE CLASS AND CUSTOMER
		select  @SelectFld1 = @InvtPriceClassID, @SelectFld2 = @CustID
	else
		select  @SelectFld1 = '', @SelectFld2 = ''

	-- If discounting by site is disabled
	If @DiscBySite = 0

		-- Search the global site
		exec @RowCount = DMG_SalesPriceDet @PriceCat, @SelectFld1, @SelectFld2, @CuryID,
			'GLOBAL', @CatalogNbr, @SlsUnit, @Quantity, @OrdDate, @SlsPrcID,
			@DiscPrcMthd OUTPUT, @DiscPrcTyp OUTPUT, @QtyBreak OUTPUT, @DiscPrice OUTPUT,
			@DiscPct OUTPUT, @ChainDisc OUTPUT, @StartDate OUTPUT, @EndDate OUTPUT, @SlsPrcIDUsed OUTPUT
	else
	begin

		-- Search the specific site
		exec @RowCount = DMG_SalesPriceDet @PriceCat, @SelectFld1, @SelectFld2, @CuryID,
			@SiteID, @CatalogNbr, @SlsUnit, @Quantity, @OrdDate, @SlsPrcID,
			@DiscPrcMthd OUTPUT, @DiscPrcTyp OUTPUT, @QtyBreak OUTPUT, @DiscPrice OUTPUT,
			@DiscPct OUTPUT, @ChainDisc OUTPUT, @StartDate OUTPUT, @EndDate OUTPUT, @SlsPrcIDUsed OUTPUT

		-- Search the global site if a specific site was not found
		if @RowCount = 0
			exec @RowCount = DMG_SalesPriceDet @PriceCat, @SelectFld1, @SelectFld2, @CuryID,
				'GLOBAL', @CatalogNbr, @SlsUnit, @Quantity, @OrdDate, @SlsPrcID,
				@DiscPrcMthd OUTPUT, @DiscPrcTyp OUTPUT, @QtyBreak OUTPUT, @DiscPrice OUTPUT,
				@DiscPct OUTPUT, @ChainDisc OUTPUT, @StartDate OUTPUT, @EndDate OUTPUT, @SlsPrcIDUsed OUTPUT
	end

	-- If the searches above found a discount price plan to use
	if @RowCount <> 0 begin

		if @DiscPrcMthd = 'F' begin -- Flat Price
			Set @CurySlsPrice = @DiscPrice
			exec DMG_CuryTransToBase @CurySlsPrice, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @SlsPrice OUTPUT
	       		Set @DiscPct = 0
			Set @ChainDisc = ''
   		end

		else if @DiscPrcMthd = 'R' begin -- Price Discount
			exec DMG_ItemPrice @InvtID, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv, @CurySlsPrice OUTPUT, @SlsPrice OUTPUT
			Set @DiscPercent = @DiscPct / 100
			Set @DiscountAmt = @CurySlsPrice * @DiscPercent
			Set @CurySlsPrice = round(@CurySlsPrice - @DiscountAmt, @DecPlPrcCst)
			exec DMG_CuryTransToBase @CurySlsPrice, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @SlsPrice OUTPUT
			Set @DiscPct = 0
			Set @ChainDisc = ''
		end

		else if @DiscPrcMthd = 'P' begin -- Percent Discount
			exec DMG_ItemPrice @InvtID, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv, @CurySlsPrice OUTPUT, @SlsPrice OUTPUT
			-- @DiscPct and ChainDisc should already be set
 		end

		else if @DiscPrcMthd = 'M' begin-- Percent Markup
			exec DMG_ItemCost @InvtID, @SiteID, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv, 0, @CuryCost OUTPUT, @Cost OUTPUT
			Set @MarkupPercent = @DiscPct / 100
			Set @MarkupAmt = @CuryCost * @MarkupPercent
			Set @CurySlsPrice = round(@CuryCost + @MarkupAmt, @DecPlPrcCst)
			exec DMG_CuryTransToBase @CurySlsPrice, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @SlsPrice OUTPUT
			Set @DiscPct = 0
			Set @ChainDisc = ''
		end

		else if @DiscPrcMthd = 'K' begin -- Price Markup
			exec DMG_ItemCost @InvtID, @SiteID, @CnvFact, @UnitMultDiv, @CuryRate, @CuryMultDiv, 0, @CuryCost OUTPUT, @Cost OUTPUT
			Set @CurySlsPrice = round(@CuryCost + @DiscPrice, @DecPlPrcCst)
			exec DMG_CuryTransToBase @CurySlsPrice, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @SlsPrice OUTPUT
			Set @DiscPct = 0
			Set @ChainDisc = ''
		end

		-- If there is no discount
		if @DiscPct = 0 begin

			-- Make the discount percent the trade discount
			Set @DiscPct = @TradeDisc
		end

		-- If chain discounts are enabled
		if @ChainDiscEnabled = 1
		begin
			-- If the chain discount is blank and there is a trade discount
			if @ChainDisc = '' and @TradeDisc <> 0 begin

				-- Casting it as a float gets rid of the trailing zeros, couldn't think of a better way to do it.
                		Set @ChainDisc = @DfltDiscountID + cast(cast(@TradeDisc as float) as varchar(10))
			end
		end

		return 1	-- Means a price plan was found
	end
	else
		return 0	-- Means a price plan was not found


