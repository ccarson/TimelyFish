 create procedure DMG_PO_REQ_InventorySelected
	@InvtID		varchar(30),
	@MaterialType	varchar(10) OUTPUT
as
	select	@MaterialType = ltrim(rtrim(MaterialType))
	from	Inventory (NOLOCK)
	where	InvtID = @InvtID

	if @@ROWCOUNT = 0 begin
		set @MaterialType = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_REQ_InventorySelected] TO [MSDSL]
    AS [dbo];

