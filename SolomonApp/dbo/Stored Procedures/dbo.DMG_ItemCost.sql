 create procedure DMG_ItemCost
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@CnvFact	decimal(25,9),
	@UnitMultDiv	varchar(1),
	@CuryRate	decimal(25,9),
	@CuryMultDiv	varchar(1),
	@UseStdCost	bit,
	@CuryCost	decimal(25,9) OUTPUT,
	@Cost		decimal(25,9) OUTPUT
as

	declare @CostWork	decimal(25,9)
	declare @DecPlPrcCst	smallint
	declare @LastCost	decimal(25,9)
	declare @StdCost	decimal(25,9)
	declare @ValMthd	varchar(1)

	-- Get the Rounding Precision value from INSetup
	select	@DecPlPrcCst = DecPlPrcCst
	from	INSetup (NOLOCK)

	-- Get the costs from the ItemSite record
	select	@LastCost = LastCost,
		@StdCost = StdCost
	from	ItemSite (NOLOCK)
	where	InvtID = @InvtID
	and	SiteID = @SiteID

	-- If there was no ItemSite record
	if @@ROWCOUNT = 0
		-- Get the costs and the valuation method from the Inventory item
		select	@LastCost = LastCost,
			@StdCost = StdCost,
			@ValMthd = ValMthd
		from	Inventory (NOLOCK)
		where	InvtID = @InvtID
	else
		-- Get the valuation method from the Inventory item
		select	@ValMthd = ValMthd
		from	Inventory (NOLOCK)
		where	InvtID = @InvtID

	-- Get either the standard cost or last cost as appropriate
	if @UseStdCost = 1 or @ValMthd = 'T'
		set @CostWork = @StdCost
	else
		set @CostWork = @LastCost

	-- Adjust the price for the unit of measure
	If @UnitMultDiv = 'M'
		Set @Cost = round(@CostWork * @CnvFact, @DecPlPrcCst)
	else begin
		if @CnvFact = 0
			Set @Cost = 0
		else
			Set @Cost = round(@CostWork / @CnvFact, @DecPlPrcCst)
	end

	-- Calculate the transaction currency value
	exec DMG_CuryBaseToTrans @Cost, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @CuryCost OUTPUT

	--select @CuryCost, @Cost



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemCost] TO [MSDSL]
    AS [dbo];

