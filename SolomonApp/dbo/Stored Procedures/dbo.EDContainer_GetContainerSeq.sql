
Create Proc EDContainer_GetContainerSeq 
@CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select Count(*) from EDContainer
Where CpnyId = @CpnyId And ShipperId = @ShipperId and ContainerID <= @ContainerId and TareFlag = 0

