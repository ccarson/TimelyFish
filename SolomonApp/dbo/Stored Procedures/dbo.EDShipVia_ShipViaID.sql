 CREATE PROCEDURE EDShipVia_ShipViaID @SCAC varchar(5) AS
Select ShipViaID From ShipVia
Where SCAC = @SCAC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipVia_ShipViaID] TO [MSDSL]
    AS [dbo];

