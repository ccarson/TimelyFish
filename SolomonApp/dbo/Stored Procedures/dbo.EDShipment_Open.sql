 Create Proc EDShipment_Open As
Select * From EDShipment Where ShipStatus = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_Open] TO [MSDSL]
    AS [dbo];

