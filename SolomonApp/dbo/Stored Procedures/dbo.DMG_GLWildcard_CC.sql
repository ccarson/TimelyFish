 create proc DMG_GLWildcard_CC
	@CustClass	varchar(6),
	@COGSAcct	varchar(10) OUTPUT,
	@COGSSub	varchar(24) OUTPUT,
	@DiscAcct	varchar(10) OUTPUT,
	@DiscSub	varchar(24) OUTPUT,
	@FrtAcct	varchar(10) OUTPUT,
	@FrtSub		varchar(24) OUTPUT,
	@MiscAcct	varchar(10) OUTPUT,
	@MiscSub	varchar(24) OUTPUT,
	@SlsAcct	varchar(10) OUTPUT,
	@SlsSub		varchar(24) OUTPUT
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
	from	CustGLClass (NOLOCK)
	where	S4Future11 = @CustClass

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


