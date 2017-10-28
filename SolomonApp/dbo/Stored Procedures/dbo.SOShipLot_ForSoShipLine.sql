 CREATE PROCEDURE SOShipLot_ForSoShipLine
	@CpnyID varchar( 10 ),
	@ShipperID varchar( 15 ),
	@LineRef varchar( 5 )
AS
	SELECT *
	FROM SOShipLot
	WHERE CpnyID = @CpnyID
	   AND ShipperID = @ShipperID
	   AND LineRef = @LineRef
	ORDER BY LotSerRef


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLot_ForSoShipLine] TO [MSDSL]
    AS [dbo];

