 CREATE PROCEDURE ADGInventory_All
	@InvtID varchar(30)
AS
	select	*
	from InventoryADG
	where 	InventoryADG.InvtId = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADGInventory_All] TO [MSDSL]
    AS [dbo];

