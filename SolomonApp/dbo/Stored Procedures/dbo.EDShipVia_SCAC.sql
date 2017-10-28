 CREATE PROCEDURE EDShipVia_SCAC @ShipViaId varchar(10) AS
Select SCAC From ShipVia
Where ShipViaID = @ShipViaId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipVia_SCAC] TO [MSDSL]
    AS [dbo];

