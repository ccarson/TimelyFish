 create proc LCReceipts_Release
	@CpnyID varchar(10)
as
select distinct
	POReceipt.CpnyID,
	POReceipt.BatNbr,
	POReceipt.RcptNbr,
	POReceipt.CuryRcptAmtTot,
	POReceipt.RcptQtyTot
from
	POReceipt,
	LCReceipt
where
	POReceipt.cpnyid like @CpnyID
	and POReceipt.Rlsed =1
	and POReceipt.RcptNbr = LCReceipt.RcptNbr
	and LCReceipt.TranStatus = 'U'
order by POReceipt.RcptNbr


