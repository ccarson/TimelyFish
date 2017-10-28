 Create Proc EDContainer_ContainersOnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select * From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareId = @TareId


