 Create Proc EDContainerDet_DistinctItemCount @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select Count(Distinct InvtId), Count(*) From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId
And ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_DistinctItemCount] TO [MSDSL]
    AS [dbo];

