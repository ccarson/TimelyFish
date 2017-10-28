 Create Proc EDContainerDet_LineRefQty @ContainerId varchar(10) As
Select LineRef, Sum(QtyShipped) From EDContainerDet Where ContainerId = @ContainerId
  Group By LineRef Order By LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_LineRefQty] TO [MSDSL]
    AS [dbo];

