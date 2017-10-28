 Create Proc EDContainer_FreightUpd @CpnyId varchar(10), @ShipperId varchar(15), @ShpCharge float, @CuryShpCharge float As
Update EDContainer Set ShpCharge = @ShpCharge, CuryShpCharge = @CuryShpCharge Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId =
(Select Max(ContainerId) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId)


