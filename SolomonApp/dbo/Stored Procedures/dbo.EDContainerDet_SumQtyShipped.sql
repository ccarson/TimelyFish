 Create Proc EDContainerDet_SumQtyShipped @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select Sum(QtyShipped) From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId


