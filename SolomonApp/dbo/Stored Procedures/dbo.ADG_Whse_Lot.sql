 CREATE PROCEDURE ADG_Whse_Lot
	@CpnyID 		varchar(10),
	@ShipperID 		varchar(15),
	@LineRef 		varchar(5)
AS
	DECLARE @WhseCount	INT,
		@LotCount	INT,
		@WhseLoc	VARCHAR(10),
		@LotSerNbr	VARCHAR(25)

	IF PATINDEX('%[%]%', @ShipperID) = 0 AND PATINDEX('%[%]%', @LineRef) = 0
		SELECT 	@WhseCount = COUNT(DISTINCT WhseLoc),
			@LotCount = COUNT(DISTINCT LotSerNbr),
			@WhseLoc = MIN(WhseLoc),
			@LotSerNbr = MIN(LotSerNbr)
		FROM 	SOShipLot
		WHERE 	SOShipLot.CpnyID = @CpnyID
		  AND	SOShipLot.ShipperID = @ShipperID
		  AND	SOShipLot.LineRef = @LineRef
	ELSE
		SELECT 	@WhseCount = COUNT(DISTINCT WhseLoc),
			@LotCount = COUNT(DISTINCT LotSerNbr),
			@WhseLoc = MIN(WhseLoc),
			@LotSerNbr = MIN(LotSerNbr)
		FROM 	SOShipLot
		WHERE 	SOShipLot.CpnyID = @CpnyID
		  AND	SOShipLot.ShipperID + '' LIKE @ShipperID
		  AND	SOShipLot.LineRef + '' LIKE @LineRef

		IF @WhseCount > 1
		SELECT 	@WhseLoc = '*'

	IF @LotCount > 1
		SELECT	@LotSerNbr = '*'

	SELECT @WhseLoc WhseLoc, @LotSerNbr LotSerNbr
	-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


