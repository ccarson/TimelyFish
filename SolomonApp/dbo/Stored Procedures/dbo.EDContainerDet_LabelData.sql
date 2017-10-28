 CREATE Proc EDContainerDet_LabelData @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10) As
Select B.Color, B.Descr, B.Size, B.User1, B.User2, B.User3, B.User4, B.User5, B.User6, B.User7,
  B.User8, B.MSDS, A.QtyShipped, A.LotSerNbr, C.InvtId, C.Pack, C.PackSize,
  Cast(C.PackUOM As varchar(6)), A.UOM, B.StkUnit, B.ClassId From EDContainerDet A Inner Join Inventory B On
  A.InvtId = B.InvtId Inner Join InventoryADG C On A.InvtId = C.InvtId Where A.CpnyId = @CpnyId
  And A.ShipperId = @ShipperId And A.ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_LabelData] TO [MSDSL]
    AS [dbo];

