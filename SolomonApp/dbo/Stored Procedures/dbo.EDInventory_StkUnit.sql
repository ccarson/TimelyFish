 Create Proc EDInventory_StkUnit @InvtId varchar(30) As
Select InvtId, StkUnit From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_StkUnit] TO [MSDSL]
    AS [dbo];

