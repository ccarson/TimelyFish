 CREATE Proc EDContainerDet_TicketMapDetails @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select InvtId, QtyShipped, LotSerNbr, WhseLoc, LineNbr From EDContainerDet Where CpnyId = @CpnyId
And ShipperId = @ShipperId And ContainerId = @ContainerId Order By CpnyId, ShipperId, ContainerId, LineNbr


