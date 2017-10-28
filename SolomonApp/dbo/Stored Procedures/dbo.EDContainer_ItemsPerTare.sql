 CREATE Proc EDContainer_ItemsPerTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select Count(Distinct B.InvtId), Max(InvtId) From EDContainer A Inner Join EDContainerDet B On A.ContainerId
 = B.ContainerId Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId And A.TareId = @TareId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_ItemsPerTare] TO [MSDSL]
    AS [dbo];

