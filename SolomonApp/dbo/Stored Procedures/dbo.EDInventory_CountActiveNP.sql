 Create Proc EDInventory_CountActiveNP @InvtId varchar(30) As
Select Count(*) From Inventory Where InvtId = @InvtId And TranStatusCode IN ('AC','NP','OH')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_CountActiveNP] TO [MSDSL]
    AS [dbo];

