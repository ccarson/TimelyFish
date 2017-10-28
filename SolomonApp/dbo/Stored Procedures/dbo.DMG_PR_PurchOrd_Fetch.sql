 create procedure DMG_PR_PurchOrd_Fetch
	@CpnyID		varchar(10),
	@PONbr		varchar(10),
	@RcptType	varchar(1)
as
	if @RcptType = 'R'
		select	*
		from 	PurchOrd (NOLOCK)
        	where 	CpnyID = @CpnyID
		and	PONbr = @PONbr
		and	POType = 'OR'
		and	Status in ('O','P')
	else if @RcptType = 'X'
		select	*
		from 	PurchOrd (NOLOCK)
        	where 	CpnyID = @CpnyID
		and	PONbr = @PONbr
		and	POType = 'OR'
		and	RcptStage in ('F','P')
	else
		select	*
		from 	PurchOrd (NOLOCK)
        	where 	1=0


