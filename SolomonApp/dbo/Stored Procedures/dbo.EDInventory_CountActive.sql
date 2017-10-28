 Create Proc EDInventory_CountActive @InvtId varchar(30) As
Select Count(*) From Inventory Where InvtId = @InvtId And TranStatusCode = 'AC'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_CountActive] TO [MSDSL]
    AS [dbo];

