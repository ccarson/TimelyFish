 CREATE PROCEDURE SOShipHeader_SHIPID_ASRREQEDD
	@parm1 varchar( 15 )
AS
	SELECT SOShipHeader.*
	FROM SOShipHeader join vs_asrreqedd on SOShipHeader.ShipperID = vs_asrreqedd.ShipperID AND vs_asrreqedd.doctype = 'O4'
	WHERE SOShipheader.ShipperID LIKE @parm1 
	ORDER BY CustID DESC

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_SHIPID_ASRREQEDD] TO [MSDSL]
    AS [dbo];

