
Create Proc SOShipHeader_SetAdminHold
	@CpnyID varchar(10),
	@ShipperID varchar(15),
	@AdminSet smallint 
AS
Update SOShipHeader
Set AdminHold = @AdminSet          
Where ShipperID = @ShipperID
	And CpnyID = @CpnyID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_SetAdminHold] TO [MSDSL]
    AS [dbo];

