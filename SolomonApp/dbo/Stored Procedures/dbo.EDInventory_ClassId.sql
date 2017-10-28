 Create Proc EDInventory_ClassId @InvtId varchar(30) As
Select ClassId From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_ClassId] TO [MSDSL]
    AS [dbo];

