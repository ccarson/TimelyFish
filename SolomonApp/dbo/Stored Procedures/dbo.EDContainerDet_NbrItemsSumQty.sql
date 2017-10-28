 Create Proc EDContainerDet_NbrItemsSumQty @ContainerId varchar(10) As
Select Count(Distinct InvtId), Count(Distinct UOM), Sum(QtyShipped) From EDContainerDet Where
ContainerId = @ContainerId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_NbrItemsSumQty] TO [MSDSL]
    AS [dbo];

