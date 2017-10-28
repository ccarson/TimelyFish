 CREATE PROCEDURE EDShipment_ShipStatus_OHT AS
Select * from EDShipment where shipstatus in ('O','H','T')


