 CREATE Proc EDInventory_LotSerTrack @InvtId varchar(30) As
Select LotSerTrack, SerAssign, StkUnit, ClassId From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_LotSerTrack] TO [MSDSL]
    AS [dbo];

