 CREATE PROCEDURE ADG_SOHeader_CustOrdNbr
	@CpnyID varchar(10),
	@CustOrdNbr varchar(25)
AS
	SELECT *
	FROM SOHeader
	WHERE CpnyID = @CpnyID AND
		CustOrdNbr LIKE @CustOrdNbr
	ORDER BY CustOrdNbr, CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


