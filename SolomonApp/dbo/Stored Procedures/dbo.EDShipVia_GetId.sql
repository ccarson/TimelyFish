 Create Proc EDShipVia_GetId @EDIViaCode varchar(20) As
Select ShipViaId From ShipVia Where EDIViaCode = @EDIViaCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipVia_GetId] TO [MSDSL]
    AS [dbo];

