 Create Proc EDWrkLabelPrint_DelCont @ContainerId varchar(10) As
Delete From EDWrkLabelPrint Where ContainerId = @ContainerId


