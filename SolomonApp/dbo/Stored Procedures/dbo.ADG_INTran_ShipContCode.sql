 create proc ADG_INTran_ShipContCode
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@LotSerNbr	varchar(25)
as
	select	ShipContCode
	from	LotSerMst
	where	InvtID = @InvtID
	  and	SiteID = @SiteID
	  and	WhseLoc = @WhseLoc
	  and	LotSerNbr = @LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_ShipContCode] TO [MSDSL]
    AS [dbo];

