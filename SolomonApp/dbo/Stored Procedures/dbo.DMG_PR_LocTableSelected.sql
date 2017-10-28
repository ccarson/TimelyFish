 create procedure DMG_PR_LocTableSelected
	@SiteID		varchar(10),
	@WhseLoc	varchar(10),
	@InclQtyAvail	smallint OUTPUT,
	@InvtID		varchar(30) OUTPUT,
	@InvtIDValid	varchar(1) OUTPUT,
	@ReceiptsValid	varchar(1) OUTPUT
as
	select	@InclQtyAvail = InclQtyAvail,
		@InvtID = ltrim(rtrim(InvtID)),
		@InvtIDValid = ltrim(rtrim(InvtIDValid)),
		@ReceiptsValid = ltrim(rtrim(ReceiptsValid))
	from	LocTable (NOLOCK)
	where	SiteID = @SiteID
	and	WhseLoc = @WhseLoc

	if @@ROWCOUNT = 0 begin
		set @InclQtyAvail = 0
		set @InvtID = ''
		set @InvtIDValid = ''
		set @ReceiptsValid = ''
		return 0	--Failure
	end
	else
		return 1	--Success


