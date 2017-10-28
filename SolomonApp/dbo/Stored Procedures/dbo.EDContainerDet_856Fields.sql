 Create Proc EDContainerDet_856Fields @ContainerId varchar(10) As
	Select Count(Distinct InvtId), Count(Distinct UOM), Sum(QtyShipped), Max(InvtId), Max(UOM)
	From EDContainerDet
	Where ContainerId = @ContainerId


