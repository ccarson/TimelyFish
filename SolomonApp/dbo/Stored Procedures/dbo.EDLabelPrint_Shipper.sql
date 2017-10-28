 Create Proc EDLabelPrint_Shipper @CpnyId varchar(10), @ShipperId varchar(10) As
Update EDContainer Set LabelLastPrinted = GetDate() Where CpnyId = @CpnyId And ShipperId = @ShipperId And LabelLastPrinted = '01-01-1900'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDLabelPrint_Shipper] TO [MSDSL]
    AS [dbo];

