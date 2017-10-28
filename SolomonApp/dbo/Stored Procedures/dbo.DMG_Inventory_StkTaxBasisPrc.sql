 create procedure DMG_Inventory_StkTaxBasisPrc
	@InvtID		varchar(30),
	@StkTaxBasisPrc	decimal(25,9) OUTPUT
as
	select	@StkTaxBasisPrc = StkTaxBasisPrc
	from	Inventory (NOLOCK)
	where	InvtID = @InvtID

	if @@ROWCOUNT = 0 begin
		set @StkTaxBasisPrc = 0
		return 0	--Failure
	end
	else
		--select @StkTaxBasisPrc
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_StkTaxBasisPrc] TO [MSDSL]
    AS [dbo];

