 CREATE Proc EDContainer_TrackingNbr @TrackingNbr varchar(30) As
Select * From EDContainer A WITH(Index(EDContainer2)) Left Outer Join EDContainerDet B On A.CpnyId = B.CpnyId And A.ShipperId =
B.ShipperId And A.ContainerId = B.ContainerId Where A.TrackingNbr = @TrackingNbr Order By A.ContainerId


