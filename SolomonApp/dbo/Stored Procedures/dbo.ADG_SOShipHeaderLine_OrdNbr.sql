 CREATE PROCEDURE ADG_SOShipHeaderLine_OrdNbr
	@CpnyID varchar(10),
	@OrdNbr varchar(15)
AS
	SELECT 	SOShipLine.*,
		SOShipHeader.ShipDateAct,
		SOShipHeader.ETADate,
		SOShipHeader.ShipCmplt,
		SOShipHeader.WeekendDelivery,
		SOShipHeader.ShipViaID,
		SOShipHeader.ShiptoID,
		SOShipHeader.ShipName,
		SOShipHeader.SiteID,
		SOShipHeader.ShipDatePlan
	FROM 	SOShipHeader
	  JOIN 	SOShipLine (NOLOCK) ON (SOShipHeader.ShipperID = SOShipLine.ShipperID)
		  AND (SOShipHeader.CpnyID = SOShipLine.CpnyID)
	WHERE 	SOShipHeader.CpnyID = @CpnyID AND
		SOShipHeader.OrdNbr LIKE @OrdNbr
	ORDER BY SOShipHeader.OrdNbr,  SOShipHeader.CustID, SOShipLine.InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeaderLine_OrdNbr] TO [MSDSL]
    AS [dbo];

