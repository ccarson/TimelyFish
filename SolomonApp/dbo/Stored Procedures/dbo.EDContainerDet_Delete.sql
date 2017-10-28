 Create Proc EDContainerDet_Delete @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Delete From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_Delete] TO [MSDSL]
    AS [dbo];

