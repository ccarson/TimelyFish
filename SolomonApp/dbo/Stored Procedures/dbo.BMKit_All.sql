 -- 11320
-- bkb 10/05/99
Create Proc BMKit_All @KitID varchar ( 30) as
	Select DISTINCT Kit.KitID from Kit, Inventory where
		Kit.KitID like @KitID
		and Inventory.Invtid = Kit.KitID
		Order by Kit.Kitid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMKit_All] TO [MSDSL]
    AS [dbo];

