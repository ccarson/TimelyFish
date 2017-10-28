 CREATE Proc EDContainer_UCC128Detail @UCC128 varchar(20) As
Select * From EDContainer A With(Index(EDContainer3)) Left Outer Join EDContainerDet B On A.CpnyId = B.CpnyId And A.ShipperId =
B.ShipperId And A.ContainerId = B.ContainerId Where A.UCC128 = @UCC128 Order By A.ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_UCC128Detail] TO [MSDSL]
    AS [dbo];

