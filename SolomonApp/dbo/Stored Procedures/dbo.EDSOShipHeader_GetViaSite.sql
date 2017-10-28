 Create Proc EDSOShipHeader_GetViaSite @CpnyId varchar(10), @ShipperId varchar(15) As
Select ShipViaId,SiteId From SOShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipHeader_GetViaSite] TO [MSDSL]
    AS [dbo];

