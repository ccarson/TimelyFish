 CREATE PROCEDURE SOShipHeader_CpnyID_OrdNbr_OKT
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3min smallint, @parm3max smallint,
	@parm4 varchar( 10 ),
	@parm5 varchar( 15 ),
	@parm6 varchar( 1 ),
	@parm7 varchar( 10 ),
	@parm8 varchar( 15 ),
	@parm9 varchar( 10 ),
	@parm10 varchar( 15 ),
	@parm11 varchar( 10 ),
	@parm12min smallint, @parm12max smallint,
	@parm13min smallint, @parm13max smallint,
	@parm14 varchar( 1 ),
	@parm15min smallint, @parm15max smallint
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	   AND OKToAppend BETWEEN @parm3min AND @parm3max
	   AND SiteID LIKE @parm4
	   AND ShipViaID LIKE @parm5
	   AND ShiptoType LIKE @parm6
	   AND ShiptoID LIKE @parm7
	   AND ShipCustID LIKE @parm8
	   AND ShipSiteID LIKE @parm9
	   AND ShipVendID LIKE @parm10
	   AND ShipAddrID LIKE @parm11
	   AND WeekendDelivery BETWEEN @parm12min AND @parm12max
	   AND MarkFor BETWEEN @parm13min AND @parm13max
	   AND Status LIKE @parm14
	   AND DropShip BETWEEN @parm15min AND @parm15max
	ORDER BY CpnyID,
	   OrdNbr,
	   OKToAppend,
	   SiteID,
	   ShipViaID,
	   ShiptoType,
	   ShiptoID,
	   ShipCustID,
	   ShipSiteID,
	   ShipVendID,
	   ShipAddrID,
	   WeekendDelivery,
	   MarkFor,
	   Status,
	   DropShip

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_CpnyID_OrdNbr_OKT] TO [MSDSL]
    AS [dbo];

