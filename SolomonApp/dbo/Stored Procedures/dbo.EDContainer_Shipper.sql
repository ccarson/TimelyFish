 CREATE Proc EDContainer_Shipper @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId Like @ContainerId Order By CpnyId,ShipperId,ContainerId


