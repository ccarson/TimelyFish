 CREATE Proc EDContainer_ShipperAll @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId Order By CpnyId, ShipperId, ContainerId


