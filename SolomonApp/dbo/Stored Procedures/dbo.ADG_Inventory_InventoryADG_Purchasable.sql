 CREATE PROCEDURE ADG_Inventory_InventoryADG_Purchasable
	@InvtID varchar(30)
AS
	-- Select the specified item if it is purchasable (i.e. its
	-- TransStatusCode is not No-Purchase, Inactive, or Deleted.
	select	Inventory.*,InventoryADG.Volume, InventoryADG.Weight
	from	Inventory
	join 	InventoryADG ON Inventory.InvtID = InventoryADG.InvtID
	where 	Inventory.InvtId = @InvtID
	and	Inventory.TranStatusCode in ('AC','NU','OH')

	-- Inventory.TransStatusCode Values:
		-- AC;Active
		-- NU;No Usage
		-- OH;On Hold
		-- NP;No Purchase
		-- IN;Inactive
		-- DE;Delete



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_InventoryADG_Purchasable] TO [MSDSL]
    AS [dbo];

