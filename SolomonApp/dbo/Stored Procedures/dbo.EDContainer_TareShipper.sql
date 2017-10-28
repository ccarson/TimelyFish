 create proc EDContainer_TareShipper @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag <> 0
Order By CpnyId,ShipperId,ContainerId


