create procedure DMG_Inventory_Sales_StkItem
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	and	TranStatusCode in ('AC','NP','OH')
	and StkItem = 1
	order by InvtID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_Sales_StkItem] TO [MSDSL]
    AS [dbo];

