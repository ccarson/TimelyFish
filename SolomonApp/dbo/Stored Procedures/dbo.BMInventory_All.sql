 -- 11250
-- bkb 6/29/99
Create Proc BMInventory_All @InvtID varchar ( 30) as
        Select * from Inventory where
		InvtID like @InvtID
		order by InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMInventory_All] TO [MSDSL]
    AS [dbo];

