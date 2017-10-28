 CREATE PROCEDURE ADG_Inventory_InventoryADG_All
	@InvtID varchar(30)
AS
	select	*
	from	Inventory
	where 	Inventory.InvtId = @InvtID
	and	Inventory.TranStatusCode in ('AC','NP','OH','NU')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_InventoryADG_All] TO [MSDSL]
    AS [dbo];

