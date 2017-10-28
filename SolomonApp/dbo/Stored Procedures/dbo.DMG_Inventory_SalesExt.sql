 create proc DMG_Inventory_SalesExt
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	and	TranStatusCode in ('AC','NP','OH', 'NU')
	order by InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_SalesExt] TO [MSDSL]
    AS [dbo];

