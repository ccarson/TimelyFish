 Create Proc EDInventory_GetDescr @InvtId varchar(30) As
Select Descr From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_GetDescr] TO [MSDSL]
    AS [dbo];

