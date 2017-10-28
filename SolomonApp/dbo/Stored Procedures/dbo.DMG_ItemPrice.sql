 create procedure DMG_ItemPrice
	@InvtID		varchar(30),
	@CnvFact	decimal(25,9),
	@UnitMultDiv	varchar(1),
	@CuryRate	decimal(25,9),
	@CuryMultDiv	varchar(1),
	@CurySlsPrice	decimal(25,9) OUTPUT,
	@SlsPrice	decimal(25,9) OUTPUT
as
	declare @DecPlPrcCst	smallint
	declare	@StkBasePrc	decimal(25,9)

	-- Get the Rounding Precision value from INSetup
	select	@DecPlPrcCst = DecPlPrcCst
	from	INSetup (NOLOCK)

	-- Get the stock base price from the inventory item
	select	@StkBasePrc = StkBasePrc
	from	Inventory (NOLOCK)
	where	InvtID = @InvtID

	-- Adjust the price for the unit of measure
	If @UnitMultDiv = 'M'
		Set @SlsPrice = round(@StkBasePrc * @CnvFact, @DecPlPrcCst)
	else begin
		if @CnvFact = 0
			Set @SlsPrice = 0
		else
			Set @SlsPrice = round(@StkBasePrc / @CnvFact, @DecPlPrcCst)
	end

	-- Calculate the transaction currency value
	exec DMG_CuryBaseToTrans @SlsPrice, @CuryRate, @CuryMultDiv, @DecPlPrcCst, @CurySlsPrice OUTPUT

	--select @CurySlsPrice, @SlsPrice


