 CREATE Proc EDInventoryADG_StdCtnInfo @InvtId varchar(30) As
Select InvtId, PackMethod, Pack, PackSize, Cast(PackUOM As char(6)) From InventoryADG Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventoryADG_StdCtnInfo] TO [MSDSL]
    AS [dbo];

