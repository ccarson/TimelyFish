 Create Proc EDInventory_DfltSite @InvtId varchar(30) As
Select DfltSite From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_DfltSite] TO [MSDSL]
    AS [dbo];

