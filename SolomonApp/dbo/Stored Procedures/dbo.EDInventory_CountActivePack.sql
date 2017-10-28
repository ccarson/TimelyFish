 Create Proc EDInventory_CountActivePack @InvtId varchar(30), @Pack int As
Select Count(*) From Inventory A Inner Join InventoryADG B On A.InvtId = B.InvtId Where
A.InvtId = @InvtId And A.TranStatusCode = 'AC' And (B.Pack * B.PackSize) = @Pack



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_CountActivePack] TO [MSDSL]
    AS [dbo];

