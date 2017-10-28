 Create Proc EDInventory_GetClassId @InvtId varchar(30) As
Select InvtId, ClassId From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_GetClassId] TO [MSDSL]
    AS [dbo];

