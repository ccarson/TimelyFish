 create procedure DMG_PO_REQ_POReqHdr_Selected_Latest
	@ReqNbr		varchar(15),
	@CuryReqTotal	decimal(25,9) OUTPUT,
	@ReqCntr	varchar(2) OUTPUT,
	@ReqTotal	decimal(25,9) OUTPUT
as
	select	@CuryReqTotal = CuryReqTotal,
		@ReqCntr = ltrim(rtrim(ReqCntr)),
		@ReqTotal = ReqTotal
	from	POReqHdr (NOLOCK)
	where	ReqNbr = @ReqNbr
	and	ReqCntr in (
			select	MAX(Convert(Numeric,ReqCntr))
			from	POReqHdr (NOLOCK)
			where	ReqNbr = @ReqNbr
			)

	if @@ROWCOUNT = 0 begin
		set @CuryReqTotal = 0
		set @ReqCntr = ''
		set @ReqTotal = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_REQ_POReqHdr_Selected_Latest] TO [MSDSL]
    AS [dbo];

