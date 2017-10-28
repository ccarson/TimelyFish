 CREATE PROCEDURE DMG_Location_GetQOH
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS
	SELECT	Sum(QtyOnHand - QtyShipNotInv - QtyAllocProjIN - ShipConfirmQty + PrjINQtyShipNotInv)
	FROM 	Location
	WHERE	SiteID like @SiteID
	and 	WhseLoc like @WhseLoc
	and	InvtID like @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Location_GetQOH] TO [MSDSL]
    AS [dbo];

