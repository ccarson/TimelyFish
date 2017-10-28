 Create Proc EDContainerDet_ItemQtyBlank @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select InvtId, Sum(QtyShipped), ' ' From EDContainerDet Where CpnyId = @CpnyId And ShipperId =
@ShipperId And ContainerId = @ContainerId Group By InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_ItemQtyBlank] TO [MSDSL]
    AS [dbo];

