 create proc DMG_Inventory_StkItem
	@InvtID		varchar(30),
	@StkItem	smallint OUTPUT
as
	select		@StkItem = StkItem
	from		Inventory (NOLOCK)
	where		InvtID = @InvtID

	if @@ROWCOUNT = 0 begin
		set @StkItem = 0
		return 0	-- Failure
	end
	else begin
		return 1	-- Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_StkItem] TO [MSDSL]
    AS [dbo];

