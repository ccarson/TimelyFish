 create procedure DMG_PR_LotSerMst_Fetch
	@InvtID		varchar(30),
	@LotSerNbr	varchar(25),
	@SiteID		varchar(10),
	@WhseLoc	varchar(10)
as
	select	*
	from	LotSerMst
	where	InvtID = @InvtID
	and	LotSerNbr = @LotSerNbr
	and	SiteID = @SiteID
	and	WhseLoc = @WhseLoc


