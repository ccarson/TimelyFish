 create procedure DMG_PR_LotSerT_Fetch_Test
	@CpnyID		varchar(10),
	@BatNbr		varchar(10)
as
	select	*
	from	LotSerT
	where	CpnyID = @CpnyID
	and	RefNbr in	(	select	RcptNbr from POReceipt (NOLOCK)
					where	CpnyID = @CpnyID
					and 	BatNbr = @BatNbr
				)
	order by INTranLineRef


