 CREATE PROCEDURE EDShipTicket_Shipper_Cpny @ShipperId varchar(15), @CpnyId varchar(10) AS
 Select * from EDShipTicket where ShipperId = @ShipperId and CpnyId = @CpnyId order by BolNbr,CpnyId,ShipperId


