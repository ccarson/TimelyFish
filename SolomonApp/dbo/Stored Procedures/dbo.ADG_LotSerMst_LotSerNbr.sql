 CREATE PROCEDURE ADG_LotSerMst_LotSerNbr
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@LotSerNbr	varchar (25)
	AS
	select 	LotSerNbr, WhseLoc, QtyOnHand
	from 	LotSerMst
	where 	InvtID like @InvtID
	and 	SiteID like @SiteID
	and 	LotSerNbr like @LotSerNbr
	and	(QtyAvail) > 0
	ORDER BY LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMst_LotSerNbr] TO [MSDSL]
    AS [dbo];

