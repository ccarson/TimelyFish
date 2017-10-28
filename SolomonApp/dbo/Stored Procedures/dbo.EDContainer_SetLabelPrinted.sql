 Create Proc EDContainer_SetLabelPrinted @CpnyId varchar(10), @ShipperId varchar(15), @ContainerId varchar(10), @TrackingNbr varchar(30), @LabelLastPrinted smalldatetime As
Update EDContainer Set LabelLastPrinted = @LabelLastPrinted, TrackingNbr = @TrackingNbr Where
CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId


