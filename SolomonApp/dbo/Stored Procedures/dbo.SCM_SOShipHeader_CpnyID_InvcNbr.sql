 CREATE PROCEDURE SCM_SOShipHeader_CpnyID_InvcNbr
	@CpnyID varchar( 10 ),
	@InvcNbr varchar( 15 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID = @CpnyID
	   AND InvcNbr = @InvcNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SOShipHeader_CpnyID_InvcNbr] TO [MSDSL]
    AS [dbo];

