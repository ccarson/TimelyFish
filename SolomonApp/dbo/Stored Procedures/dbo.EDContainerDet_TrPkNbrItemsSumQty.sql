 CREATE Proc EDContainerDet_TrPkNbrItemsSumQty @CpnyId varchar(10), @ShipperId varchar(15), @ContainerID varchar(10)
As
--Calculates the number of lines,qty for loose containers in a shipper
	Select 	Count(Distinct B.InvtId), Count(Distinct B.UOM),
       		ISNULL(Sum(B.QtyShipped),0), Count(Distinct A.ContainerId)
	From EDContainer A
		Inner Join EDContainerDet B
			On A.ContainerId = B.ContainerId
	Where 	A.CpnyId = @CpnyId And
		A.ShipperId = @ShipperId And
		-- A.TareId = @TareId And
		A.ContainerID = @ContainerID And
		A.TareFlag = 0 And A.TareID = ''


