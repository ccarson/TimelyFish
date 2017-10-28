 CREATE Proc EDInventory_LotSerialTrack @InvtId varchar(30) As
Select LotSerTrack, SerAssign From Inventory Where InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_LotSerialTrack] TO [MSDSL]
    AS [dbo];

