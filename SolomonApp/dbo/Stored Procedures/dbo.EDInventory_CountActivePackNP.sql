 Create Proc EDInventory_CountActivePackNP @InvtId varchar(30), @Pack int As
Select Count(*) From Inventory A Inner Join InventoryADG B On A.InvtId = B.InvtId Where
A.InvtId = @InvtId And A.TranStatusCode IN ('AC','NP','OH') And (B.Pack * B.PackSize) = @Pack



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_CountActivePackNP] TO [MSDSL]
    AS [dbo];

