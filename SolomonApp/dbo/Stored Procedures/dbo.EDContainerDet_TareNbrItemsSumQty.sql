 CREATE Proc EDContainerDet_TareNbrItemsSumQty @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10) As
Select Count(Distinct B.InvtId), Count(Distinct B.UOM), Sum(B.QtyShipped), Count(Distinct A.ContainerId)
From EDContainer A Inner Join EDContainerDet B On A.ContainerId = B.ContainerId Where A.CpnyId = @CpnyId And
A.ShipperId = @ShipperId And A.TareId = @TareId


