 CREATE PROCEDURE DMG_LotSerMst_GetQOH
	@InvtID		varchar (30),
	@LotSerNbr	varchar (25),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS
	SELECT	Sum(QtyOnHand- QtyShipNotInv - QtyAllocProjIN - ShipConfirmQty + PrjINQtyShipNotInv)
	FROM 	LotSerMst
	WHERE	SiteID like @SiteID
	and 	WhseLoc like @WhseLoc
	and	LotSerNbr like @LotSerNbr
	and	InvtID like @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_LotSerMst_GetQOH] TO [MSDSL]
    AS [dbo];

