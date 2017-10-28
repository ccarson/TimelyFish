 Create Proc EDSOShipHeader_ResetLastEDIDate @CpnyId varchar(10), @ShipperId varchar(15) As
Update EDSOShipHeader Set LastEDIDate = '01/01/1900' Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_ResetLastEDIDate] TO [MSDSL]
    AS [dbo];

