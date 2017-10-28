 CREATE PROCEDURE EDShipTicket_BolNumber @CpnyID varchar(10), @ShipperID varchar(15) AS
Select BOLNBR From EDShipTicket
Where CpnyId = @CpnyID
And ShipperId = @ShipperID


