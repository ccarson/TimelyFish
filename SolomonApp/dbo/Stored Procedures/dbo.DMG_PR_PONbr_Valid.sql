 create procedure DMG_PR_PONbr_Valid
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@RcptType	varchar(1)
as
	if @RcptType = 'R' begin
		if (
		select	count(*)
		from 	PurchOrd (NOLOCK)
        	where 	CpnyID = @CpnyID
		and	PONbr = @PONbr
		and	POType = 'OR'
		and	Status in ('O','P')
 		) = 0
			--select 0
			return 0	--Failure
		else
			--select 1
			return 1	--Success
	end
	else if @RcptType = 'X' begin
		if (
		select	count(*)
		from 	PurchOrd (NOLOCK)
        	where 	CpnyID = @CpnyID
		and	PONbr = @PONbr
		and	POType = 'OR'
		and	RcptStage in ('F','P')
 		) = 0
			--select 0
			return 0	--Failure
		else
			--select 1
			return 1	--Success
	end
	else
		--select 0
		return 0	--Failure


