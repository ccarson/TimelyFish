 CREATE Proc EDContainer_LineNbrsOnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select A.ContainerId, B.InvtId, B.LineNbr From EDContainer A Inner Join EDContainerDet B On A.CpnyId =
B.CpnyId And A.ShipperId = B.ShipperId And A.ContainerId = B.ContainerId Where A.CpnyId = @CpnyId
And A.ShipperId = @ShipperId And A.TareId = @TareId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_LineNbrsOnTare] TO [MSDSL]
    AS [dbo];

