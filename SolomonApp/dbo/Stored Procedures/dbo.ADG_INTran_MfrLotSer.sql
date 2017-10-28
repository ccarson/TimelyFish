 create proc ADG_INTran_MfrLotSer
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@LotSerNbr	varchar(25)
as
	select	MfgrLotSerNbr
	from	LotSerMst
	where	InvtID = @InvtID
	  and	SiteID = @SiteID
	  and	WhseLoc = @WhseLoc
	  and	LotSerNbr = @LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_MfrLotSer] TO [MSDSL]
    AS [dbo];

