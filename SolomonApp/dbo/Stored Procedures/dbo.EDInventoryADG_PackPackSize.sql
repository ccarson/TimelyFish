 Create Proc EDInventoryADG_PackPackSize @Invtid varchar(30) As
Select Pack, PackSize From InventoryADG Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventoryADG_PackPackSize] TO [MSDSL]
    AS [dbo];

