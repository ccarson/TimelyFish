 create procedure DMG_PR_INSetupSelected
	@CurrPerNbr	varchar(6) OUTPUT,
	@DecPlQty	smallint OUTPUT,
	@DfltSite	varchar(10) OUTPUT,
	@MultWhse	smallint OUTPUT,
	@WhseLocValid	varchar(1) OUTPUT,
	@IssuesAcct	varchar(10) OUTPUT,
	@IssuesSubAcct	varchar(30) OUTPUT
as
	select	@CurrPerNbr = ltrim(rtrim(CurrPerNbr)),
		@DecPlQty = DecPlQty,
		@DfltSite = ltrim(rtrim(DfltSite)),
		@MultWhse = MultWhse,
		@WhseLocValid = ltrim(rtrim(WhseLocValid)),
		@IssuesAcct = S4Future12,
		@IssuesSubAcct = S4Future01
	from	INSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CurrPerNbr = ''
		set @DecPlQty = 0
		set @DfltSite = ''
		set @MultWhse = 0
		set @WhseLocValid = ''
		set @IssuesAcct = ''
		set @IssuesSubAcct = ''

		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_INSetupSelected] TO [MSDSL]
    AS [dbo];

