 CREATE Proc EDInventory_ClassStkUnit @InvtId varchar(30) As
Select ClassId,StkUnit,InvtId From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_ClassStkUnit] TO [MSDSL]
    AS [dbo];

