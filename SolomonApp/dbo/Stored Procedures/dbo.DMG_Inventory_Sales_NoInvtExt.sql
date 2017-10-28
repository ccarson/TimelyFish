 create proc DMG_Inventory_Sales_NoInvtExt
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	and	TranStatusCode in ('AC','NP','NU')
	order by InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_Sales_NoInvtExt] TO [MSDSL]
    AS [dbo];

