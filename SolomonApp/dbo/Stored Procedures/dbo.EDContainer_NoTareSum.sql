 Create Proc EDContainer_NoTareSum @CpnyId varchar(10), @ShipperId varchar (15), @LineRef varchar(5) As
Select Sum(B.QtyShipped) From EDContainer A, EDContainerDet B Where A.CpnyId = @CpnyId And
  A.ShipperId = @ShipperId And LTrim(RTrim(A.TareId)) = '' And A.ContainerId = B.ContainerId
  And B.LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_NoTareSum] TO [MSDSL]
    AS [dbo];

