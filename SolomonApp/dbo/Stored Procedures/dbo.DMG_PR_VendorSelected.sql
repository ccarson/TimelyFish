 create procedure DMG_PR_VendorSelected
	@VendID		varchar(15),
        @APAcct		varchar(10) OUTPUT,
	@APSub		varchar(24) OUTPUT,
	@CuryID		varchar(4) OUTPUT,
	@CuryRateType	varchar(6) OUTPUT,
	@PayDateDflt	varchar(1) OUTPUT,
        @PmtMethod	varchar(1) OUTPUT,
	@Vend1099	smallint OUTPUT
as
	select	@APAcct = ltrim(rtrim(APAcct)),
		@APSub = ltrim(rtrim(APSub)),
		@CuryID = ltrim(rtrim(CuryID)),
		@CuryRateType = ltrim(rtrim(CuryRateType)),
		@PayDateDflt = ltrim(rtrim(PayDateDflt)),
		@PmtMethod = ltrim(rtrim(PmtMethod)),
		@Vend1099 = Vend1099
	from	Vendor (NOLOCK)
	where	VendID = @VendID

	if @@ROWCOUNT = 0 begin
		set @APAcct = ''
		set @APSub = ''
		set @CuryID = ''
		set @CuryRateType = ''
		set @PayDateDflt = ''
		set @PmtMethod = ''
		set @Vend1099 = ''
		return 0	--Failure
	end
	else
		return 1	--Success


