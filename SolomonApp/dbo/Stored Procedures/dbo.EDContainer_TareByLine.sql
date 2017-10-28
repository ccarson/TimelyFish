 CREATE Proc EDContainer_TareByLine @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select A.*,B.LineRef From EDContainer A Inner Join EDContainerDet B On A.ContainerId = B.ContainerId Where
  A.CpnyId = @CpnyId And A.ShipperId = @ShipperId And A.TareId = @TareId


