 create proc DMG_GLWildcard_SI
	@SiteID		varchar(10),
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(31) OUTPUT,
	@DiscAcct	varchar(10) OUTPUT,
	@DiscSub	varchar(31) OUTPUT,
	@FrtAcct	varchar(10) OUTPUT,
	@FrtSub		varchar(31) OUTPUT,
	@MiscAcct	varchar(10) OUTPUT,
	@MiscSub	varchar(30) OUTPUT,
	@SlsAcct	varchar(10) OUTPUT,
	@SlsSub		varchar(31) OUTPUT
as
	select	@COGSAcct = ltrim(rtrim(COGSAcct)),
		@COGSSub = ltrim(rtrim(COGSSub)),
		@DiscAcct = ltrim(rtrim(DicsAcct)),
		@DiscSub = ltrim(rtrim(DiscSub)),
		@FrtAcct = ltrim(rtrim(FrtAcct)),
		@FrtSub = ltrim(rtrim(FrtSub)),
		@MiscAcct = ltrim(rtrim(S4Future11)),
		@MiscSub = ltrim(rtrim(S4Future01)),
		@SlsAcct = ltrim(rtrim(SlsAcct)),
		@SlsSub = ltrim(rtrim(SlsSub))
	from	Site (NOLOCK)
	where	SiteID = @SiteID

	if @@ROWCOUNT = 0 begin
		set @COGSAcct = ''
		set @COGSSub = ''
		set @DiscAcct = ''
		set @DiscSub = ''
		set @FrtAcct = ''
		set @FrtSub = ''
		set @MiscAcct = ''
		set @MiscSub = ''
		set @SlsAcct = ''
		set @SlsSub = ''
		return 0	--Failure
	end
	else
		return 1	--Success


