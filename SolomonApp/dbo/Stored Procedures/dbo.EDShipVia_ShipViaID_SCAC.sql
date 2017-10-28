 CREATE PROCEDURE EDShipVia_ShipViaID_SCAC @EDIViaCode varchar(20) AS
Select ShipViaID,SCAC From ShipVia
Where EDIViaCode = @EDIViaCode


