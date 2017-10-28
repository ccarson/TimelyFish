 CREATE PROCEDURE EDShipTick_FindOld @ShipperID varchar(15), @BolNbr varchar(20), @CpnyID varchar(10) AS
select * from EDShipTicket where ShipperID = @ShipperID and bolnbr <> @BolNbr and CpnyID = @CpnyID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipTick_FindOld] TO [MSDSL]
    AS [dbo];

