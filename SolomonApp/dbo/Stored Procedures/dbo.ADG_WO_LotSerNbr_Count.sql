 CREATE PROCEDURE ADG_WO_LotSerNbr_Count
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@LotSerNbr	varchar (25)

AS
	SELECT	Count(*)
	FROM 	LotSerMst
	WHERE	InvtID like @InvtID
	  AND 	SiteID like @SiteID
	  AND 	LotSerNbr like @LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


