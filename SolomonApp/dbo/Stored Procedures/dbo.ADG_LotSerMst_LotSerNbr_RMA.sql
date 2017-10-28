 CREATE PROCEDURE ADG_LotSerMst_LotSerNbr_RMA
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@LotSerNbr	varchar (25),
	@LotSerTrack    varchar (2)
	AS
	select 	LotSerNbr, WhseLoc, QtyOnHand
	from 	LotSerMst
	where 	InvtID like @InvtID
	and 	SiteID like @SiteID
	and 	LotSerNbr like @LotSerNbr
	and	LotSerNbr <> '*'
        and     (QtyOnHand = 0 or @LotSerTrack = 'LI')
	ORDER BY LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMst_LotSerNbr_RMA] TO [MSDSL]
    AS [dbo];

