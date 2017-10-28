 CREATE PROCEDURE DMG_PR_POTran_Receipts_Fetch
	@CpnyID		varchar(10),
	@PONbr 		varchar(10),
	@POLineRef	varchar(5),
	@RcptNbr	varchar(10)
AS
	select 	POTran.*
	from 	POTran
	join	POReceipt (NOLOCK) on POReceipt.CpnyID = POTran.CpnyID and POReceipt.RcptNbr = POTran.RcptNbr
	where 	POTran.CpnyID = @CpnyID
	and	POTran.PONbr = @PONbr
	and	POTran.POLineRef like @POLineRef
	and	POTran.RcptNbr like @RcptNbr
	and 	POTran.TranType = 'R'
	and	POReceipt.Rlsed = 1


