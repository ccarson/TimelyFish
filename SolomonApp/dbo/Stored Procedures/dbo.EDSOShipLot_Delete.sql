 CREATE PROCEDURE EDSOShipLot_Delete @ShipperID varchar(15), @CpnyID varchar(10), @LineRef varchar(5) AS
Delete from soshiplot
where shipperid = @ShipperID
 and cpnyid = @Cpnyid
 and lineref = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLot_Delete] TO [MSDSL]
    AS [dbo];

