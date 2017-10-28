 Create Proc EDShipment_ByShipper @CpnyId varchar(10), @ShipperId varchar(10) As
Select * From EDShipment Where BOLNbr = (Select BOLNbr From EDShipTicket Where CpnyId = @CpnyID
And ShipperId = @ShipperId)


