 CREATE PROCEDURE ADG_UpdSh_SOShipLine
	@CpnyID 	varchar(10),
	@ShipperID 	varchar(15),
	@LineRef 	varchar(5)
AS
	SELECT *
	FROM SOShipLine (UPDLOCK)
	WHERE CpnyID = @CpnyID
	   AND ShipperID LIKE @ShipperID
	   AND LineRef LIKE @LineRef
	ORDER BY CpnyID, ShipperID, LineRef


