 Create Proc EDContainer_DistinctItemsPerTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select Distinct B.Invtid From EDContainer A Inner Join EDContainerDet B On A.CpnyId = B.CpnyId
And A.ShipperId = B.ShipperId And A.ContainerId = B.ContainerId Where A.TareId = @TareId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_DistinctItemsPerTare] TO [MSDSL]
    AS [dbo];

