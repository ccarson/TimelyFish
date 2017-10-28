 CREATE PROCEDURE EDShipTicket_Update_BOL @BolNbr varchar(20), @CpnyID varchar(10), @ShipperID varchar(15) AS
Update EDShipTicket
Set BOLNbr = @BolNbr
Where CpnyId = @CpnyID
And ShipperId = @ShipperID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTicket_Update_BOL] TO [MSDSL]
    AS [dbo];

