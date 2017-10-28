 Create Proc EDContainer_ClearLabelLastPrinted @CpnyId varchar(10), @ShipperId varchar(15) As
Update EDContainer Set LabelLastPrinted = '01/01/1900' Where CpnyId = @CpnyId And ShipperId = @ShipperId


