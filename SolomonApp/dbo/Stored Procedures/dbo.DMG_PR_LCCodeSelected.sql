 create procedure DMG_PR_LCCodeSelected
	@LCCode			varchar(10),
	@CostAllocCode		varchar(1),
	@QtyAllocCode		varchar(1),
	@WeightAllocCode	varchar(1),
	@AllocMethod		varchar(1) OUTPUT,
	@ReasonCd		varchar(6) OUTPUT,
	@TermsID		varchar(2) OUTPUT,
	@VendID			varchar(15) OUTPUT
as
	select	@AllocMethod = ltrim(rtrim(AllocMethod)),
		@ReasonCd = ltrim(rtrim(ReasonCd)),
		@TermsID = ltrim(rtrim(TermsID)),
		@VendID = ltrim(rtrim(VendID))
	from	LCCode (NOLOCK)
	where	LCCode = @LCCode
	and	ApplMethod in ('B','R')
	and	AllocMethod in (@CostAllocCode,@QtyAllocCode,@WeightAllocCode)

	if @@ROWCOUNT = 0 begin
		set @AllocMethod = ''
		set @ReasonCd = ''
		set @TermsID = ''
		set @VendID = ''
		return 0	--Failure
	end
	else
		--select @AllocMethod, @ReasonCd, @TermsID, @VendID
		return 1	--Success


