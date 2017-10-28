 Create Proc Inventory_All_RO @InvtID varchar ( 30) as
        Select * from Inventory (NoLock) where InvtId like @InvtID order by InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Inventory_All_RO] TO [MSDSL]
    AS [dbo];

