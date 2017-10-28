 create proc EDContainer_ShipperTare @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId Like @ContainerId And TareFlag <> 0
Order By CpnyId,ShipperId,ContainerId


