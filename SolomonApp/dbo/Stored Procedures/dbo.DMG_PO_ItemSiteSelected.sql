 create procedure DMG_PO_ItemSiteSelected
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@AvgCost	decimal(25,9) OUTPUT,
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(25) OUTPUT,
	@DfltPOUnit	varchar(6) OUTPUT,
	@DirStdCst	decimal(25,9) OUTPUT,
	@InvtAcct	varchar(10) OUTPUT,
	@InvtSub	varchar(24) OUTPUT,
	@LastCost	decimal(25,9) OUTPUT
as
	select	@AvgCost = AvgCost,
		@COGSAcct = ltrim(rtrim(COGSAcct)),
		@COGSSub = ltrim(rtrim(COGSSub)),
		@DfltPOUnit = ltrim(rtrim(DfltPOUnit)),
		@DirStdCst = DirStdCst,
		@InvtAcct = ltrim(rtrim(InvtAcct)),
		@InvtSub = ltrim(rtrim(InvtSub)),
		@LastCost = LastCost
	from	ItemSite (NOLOCK)
	where	InvtID = @InvtID
	and	SiteID = @SiteID

	if @@ROWCOUNT = 0 begin
		set @AvgCost = 0
		set @CogsAcct = ''
		set @CogsSub = ''
		set @DfltPOUnit = ''
		set @DirStdCst = 0
		set @InvtAcct = ''
		set @InvtSub = ''
		set @LastCost = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_ItemSiteSelected] TO [MSDSL]
    AS [dbo];

