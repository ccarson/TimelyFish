 CREATE PROCEDURE ADG_SOShipHeader_OrdNbr
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID = @CpnyID AND
		OrdNbr LIKE @OrdNbr
	ORDER BY OrdNbr, CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


