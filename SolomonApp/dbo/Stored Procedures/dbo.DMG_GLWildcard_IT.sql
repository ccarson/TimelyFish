 create proc DMG_GLWildcard_IT
	@InvtID		varchar(30),
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(31) OUTPUT,
	@DiscAcct	varchar(10) OUTPUT,
	@DiscSub	varchar(31) OUTPUT,
	@SlsAcct	varchar(10) OUTPUT,
	@SlsSub		varchar(31) OUTPUT
as
	select	@COGSAcct = ltrim(rtrim(OMCOGSAcct)),
		@COGSSub = ltrim(rtrim(OMCOGSSub)),
		@DiscAcct = ltrim(rtrim(DiscAcct)),
		@DiscSub = ltrim(rtrim(DiscSub)),
		@SlsAcct = ltrim(rtrim(OMSalesAcct)),
		@SlsSub = ltrim(rtrim(OMSalesSub))
	from	Inventory (NOLOCK)
	join	InventoryADG (NOLOCK) on InventoryADG.InvtID = Inventory.InvtID
	where	Inventory.InvtID = @InvtID

	if @@ROWCOUNT = 0 begin
		set @COGSAcct = ''
		set @COGSSub = ''
		set @DiscAcct = ''
		set @DiscSub = ''
		set @SlsAcct = ''
		set @SlsSub = ''
		return 0	--Failure
	end
	else
		return 1	--Success


