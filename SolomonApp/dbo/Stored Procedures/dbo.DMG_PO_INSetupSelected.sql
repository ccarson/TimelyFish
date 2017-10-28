 create procedure DMG_PO_INSetupSelected
	@APClearingAcct		varchar(10) OUTPUT,
	@APClearingSub		varchar(24) OUTPUT,
	@DfltSite		varchar(10) OUTPUT,
	@MultWhse		smallint OUTPUT,
	@IssuesAcct		varchar(10) OUTPUT,
	@SubIssuesAcct		varchar(30) OUTPUT
as
	select	@APClearingAcct = ltrim(rtrim(APClearingAcct)),
		@APClearingSub = ltrim(rtrim(APClearingSub)),
		@DfltSite = ltrim(rtrim(DfltSite)),
		@MultWhse = MultWhse,
		@IssuesAcct = S4Future12,
		@SubIssuesAcct = S4Future01
	from	INSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @APClearingAcct = ''
		set @APClearingSub = ''
		set @DfltSite = ''
		set @MultWhse = 0
		set @IssuesAcct = ''
		set @SubIssuesAcct = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_INSetupSelected] TO [MSDSL]
    AS [dbo];

