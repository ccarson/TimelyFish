 create procedure DMG_PR_PONbr_Already_Referenced
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@BatNbr		varchar(10) OUTPUT
as
	select	@BatNbr = POReceipt.BatNbr
	from 	POReceipt (NOLOCK)
        inner join potran (NOLOCK) on potran.rcptnbr = poreceipt.rcptnbr
        where 	POReceipt.CpnyID = @CpnyID
	and	POTRan.PONbr = @PONbr
	and	POReceipt.Rlsed = 0

	if @@ROWCOUNT = 0 begin
		set @BatNbr = ''
		return 0	--Failure
	end
	else
		--select 1
		return 1	--Success


