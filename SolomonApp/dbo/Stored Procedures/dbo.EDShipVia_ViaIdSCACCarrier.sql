 Create Proc EDShipVia_ViaIdSCACCarrier @ShipViaId varchar(15) As
Select ShipViaId, SCAC, CarrierId From ShipVia Where ShipViaId = @ShipViaId


