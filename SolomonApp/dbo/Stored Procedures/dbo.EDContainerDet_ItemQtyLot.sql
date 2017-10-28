 Create Proc EDContainerDet_ItemQtyLot @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select InvtId, QtyShipped, LotSerNbr From EDContainerDet Where CpnyId = @CpnyId And ShipperId =
@ShipperId And ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ItemQtyLot] TO [MSDSL]
    AS [dbo];

