 Create Proc EDSOShipHeaderHeader_SetLastEDIDate @CpnyId varchar(10), @ShipperId varchar(15) As
Update EDSOShipHeader Set LastEDIDate = GetDate() Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeaderHeader_SetLastEDIDate] TO [MSDSL]
    AS [dbo];

