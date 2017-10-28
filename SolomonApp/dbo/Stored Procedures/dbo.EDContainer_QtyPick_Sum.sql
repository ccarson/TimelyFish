 CREATE Proc [dbo].[EDContainer_QtyPick_Sum] @CpnyID varchar(10), @ShipperID varchar(15) AS
	SELECT A.LineRef, A.QtyPick 'OrigPickQty',A.QtyPick - Sum(Coalesce(B.QtyShipped,0)) 'PickQty',
  Sum(Coalesce(B.QtyShipped,0)) 'ShipQty', A.InvtId, A.UnitDesc
  From SOShipLine A Left Outer Join EDContainerDet B On A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId And
 A.LineRef = B.LineRef
 Where A.CpnyId = @CpnyID and A.ShipperId = @ShipperID
  Group By A.LineRef, A.QtyPick, A.InvtId, A.UnitDesc Order By A.LineRef


