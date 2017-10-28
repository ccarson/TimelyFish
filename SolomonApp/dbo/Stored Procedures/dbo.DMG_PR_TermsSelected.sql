 create procedure DMG_PR_TermsSelected
	@TermsID	varchar(2),
        @DiscIntrv	smallint OUTPUT,
	@DiscPct	decimal(25,9) OUTPUT,
	@DiscType	varchar(1) OUTPUT,
        @DueIntrv	smallint OUTPUT,
	@DueType	varchar(1) OUTPUT
as
	select	@DiscIntrv = DiscIntrv,
		@DiscPct = DiscPct,
		@DiscType = ltrim(rtrim(DiscType)),
		@DueIntrv = DueIntrv,
		@DueType = ltrim(rtrim(DueType))
	from	Terms (NOLOCK)
	where	TermsID = @TermsID

	if @@ROWCOUNT = 0 begin
		set @DiscIntrv = 0
		set @DiscPct = 0
		set @DiscType = ''
		set @DueIntrv = 0
		set @DueType = ''
		return 0	--Failure
	end
	else
		return 1	--Success


