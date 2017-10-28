 create procedure DMG_PO_VendorSelected
	@VendID			varchar(15),
	@CuryID			varchar(4) OUTPUT,
	@CuryRateType		varchar(6) OUTPUT,
	@DfltOrdFromID		varchar(10) OUTPUT,
	@DfltPurchaseType	varchar(2) OUTPUT,
	@ExpAcct		varchar(10) OUTPUT,
	@ExpSub			varchar(24) OUTPUT,
	@PerNbr			varchar(6) OUTPUT,
	@RcptPctAct		varchar(1) OUTPUT,
	@RcptPctMax		decimal(25,9) OUTPUT,
	@RcptPctMin		decimal(25,9) OUTPUT,
	@Status			varchar(1) OUTPUT,
	@Terms			varchar(2) OUTPUT
as
	select	@CuryID = ltrim(rtrim(CuryID)),
		@CuryRateType = ltrim(rtrim(CuryRateType)),
		@DfltOrdFromID = ltrim(rtrim(DfltOrdFromID)),
		@DfltPurchaseType = ltrim(rtrim(DfltPurchaseType)),
		@ExpAcct = ltrim(rtrim(ExpAcct)),
		@ExpSub = ltrim(rtrim(ExpSub)),
		@PerNbr = ltrim(rtrim(PerNbr)),
		@RcptPctAct = ltrim(rtrim(RcptPctAct)),
		@RcptPctMax = RcptPctMax,
		@RcptPctMin = RcptPctMin,
		@Status = ltrim(rtrim(Status)),
		@Terms = ltrim(rtrim(Terms))
	from	Vendor (NOLOCK)
	where	VendID = @VendID

	if @@ROWCOUNT = 0 begin
		set @CuryID = ''
		set @CuryRateType = ''
		set @DfltOrdFromID = ''
		set @DfltPurchaseType = ''
		set @ExpAcct = ''
		set @ExpSub = ''
		set @PerNbr = ''
		set @RcptPctAct = ''
		set @RcptPctMax = 0
		set @RcptPctMin = 0
		set @Status = ''
		set @Terms = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_VendorSelected] TO [MSDSL]
    AS [dbo];

