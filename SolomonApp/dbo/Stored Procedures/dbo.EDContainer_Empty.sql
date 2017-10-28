 Create Proc EDContainer_Empty @CpnyId varchar(10), @ShipperId varchar(15) As
Select ContainerId From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And
TareFlag = 0 And ContainerId Not In (Select Distinct ContainerId From EDContainerDet Where
CpnyId = @CpnyId And ShipperId = @ShipperId)


