 create proc DMG_Plan_GetPack
	@InvtID		varchar(30),
	@Pack		smallint OUTPUT,
	@PackCnvFact	decimal(25,9) OUTPUT,
	@PackMethod	varchar(2) OUTPUT,
	@PackSize	smallint OUTPUT,
	@PackUnitMultDiv varchar(1) OUTPUT,
	@StdCartonBreak smallint OUTPUT
as
	select	@Pack = Pack,
		@PackCnvFact = PackCnvFact,
		@PackMethod = ltrim(rtrim(PackMethod)),
		@PackSize = PackSize,
		@PackUnitMultDiv = ltrim(rtrim(PackUnitMultDiv)),
		@StdCartonBreak = StdCartonBreak
	from	InventoryADG (NOLOCK)
	where	InvtID = @InvtID

	if @@ROWCOUNT = 0 begin
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end


