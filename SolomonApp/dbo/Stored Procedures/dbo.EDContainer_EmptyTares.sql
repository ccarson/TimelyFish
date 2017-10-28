 Create Proc EDContainer_EmptyTares @CpnyId varchar(10), @ShipperId varchar(15) As
Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And
TareFlag = 1 And ContainerId Not In (Select Distinct TareId From EDContainer Where
CpnyId = @CpnyId And ShipperId = @ShipperId)


