 Create Proc EDContainerDet_ItemQtyUOMCount @CpnyId varchar(10), @ShipperId varchar(15), @TareId varchar(10)
As
	SELECT Count(Distinct A.InvtId), Count(Distinct A.QtyShipped), Count(Distinct A.UOM),
		Max(A.InvtId), Max(A.QtyShipped), Max(A.UOM)
	FROM 	EDContainerDet A Inner Join EDContainer B On A.ContainerId = B.ContainerId
	WHERE 	A.CpnyId = @CpnyId And A.ShipperId = @ShipperId And B.TareId = @TareId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ItemQtyUOMCount] TO [MSDSL]
    AS [dbo];

