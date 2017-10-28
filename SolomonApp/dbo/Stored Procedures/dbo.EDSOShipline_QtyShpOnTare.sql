 CREATE Procedure EDSOShipline_QtyShpOnTare @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10), @LineRef varchar(5)
As
--Sums the qtyshipped on the container detail records for specified lineitem.
	Select ISNULL(SUM(A.QtyShipped),0)  -- a.qtyshipped
	From EDContainerDet A Join EDContainer B on A.ContainerID = B.ContainerID
	Where 	B.CpnyID = @CpnyID And
		B.ShipperID = @ShipperID And
		B.TareID = @TareID And
		A.LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipline_QtyShpOnTare] TO [MSDSL]
    AS [dbo];

