 Create Procedure DMG_ItemCost_RcptNbr
	@InvtID varchar (30),
	@SiteID varchar (10),
	@RcptNbr varchar (10)
as
	Select	*
	from	ItemCost
	where	InvtId = @InvtID
        and	SiteId = @SiteID
	and 	RcptNbr like @RcptNbr
        order by InvtId, SiteId, RcptNbr


