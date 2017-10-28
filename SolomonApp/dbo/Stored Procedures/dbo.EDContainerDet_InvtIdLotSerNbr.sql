 Create Proc EDContainerDet_InvtIdLotSerNbr @CpnyId varchar(10), @ShipperId varchar(15) As
Select A.InvtId, A.LotSerNbr From EDContainerDet A, Inventory B Where A.CpnyId = @CpnyId And
A.ShipperId = @ShipperId And A.InvtId = B.InvtId And B.LotSerTrack = 'SI'
Order By A.InvtId, A.LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_InvtIdLotSerNbr] TO [MSDSL]
    AS [dbo];

