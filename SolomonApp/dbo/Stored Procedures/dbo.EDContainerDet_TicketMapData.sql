 CREATE Proc EDContainerDet_TicketMapData @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select InvtId, QtyShipped, LotSerNbr, WhseLoc, UOM From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId Order By InvtId


