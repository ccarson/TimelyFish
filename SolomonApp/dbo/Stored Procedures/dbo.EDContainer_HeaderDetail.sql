 CREATE Proc EDContainer_HeaderDetail @CpnyId varchar(10), @ShipperId varchar(15) As
Select * From EDContainer A Left Outer Join EDContainerDet B On A.CpnyId = B.CpnyId And A.ShipperId =
B.ShipperId And A.ContainerId = B.ContainerId Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId
Order By A.ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_HeaderDetail] TO [MSDSL]
    AS [dbo];

