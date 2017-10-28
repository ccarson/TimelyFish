 create proc DMG_GLWildcard_CU
	@CustID		varchar(15),
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(31) OUTPUT,
	@DiscAcct	varchar(10) OUTPUT,
	@DiscSub	varchar(31) OUTPUT,
	@FrtAcct	varchar(10) OUTPUT,
	@FrtSub		varchar(31) OUTPUT,
	@MiscAcct	varchar(10) OUTPUT,
	@MiscSub	varchar(31) OUTPUT,
	@SlsAcct	varchar(10) OUTPUT,
	@SlsSub		varchar(31) OUTPUT
as
	select	@COGSAcct = ltrim(rtrim(COGSAcct)),
		@COGSSub = ltrim(rtrim(COGSSub)),
		@DiscAcct = ltrim(rtrim(DiscAcct)),
		@DiscSub = ltrim(rtrim(DiscSub)),
		@FrtAcct = ltrim(rtrim(FrtAcct)),
		@FrtSub = ltrim(rtrim(FrtSub)),
		@MiscAcct = ltrim(rtrim(MiscAcct)),
		@MiscSub = ltrim(rtrim(MiscSub)),
		@SlsAcct = ltrim(rtrim(SlsAcct)),
		@SlsSub = ltrim(rtrim(SlsSub))
	from	CustomerEDI (NOLOCK)
	where	CustID = @CustID

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


