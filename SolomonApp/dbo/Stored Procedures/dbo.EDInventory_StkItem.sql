 Create Proc EDInventory_StkItem @InvtId varchar(30) As
Select StkItem From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_StkItem] TO [MSDSL]
    AS [dbo];

