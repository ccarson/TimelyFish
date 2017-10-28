 Create Proc ADG_LoadAlloc_POTran
	@BatNbr		Varchar(10),
	@RcptNbr	Varchar(10)
As

SELECT	POTRan.LineRef, POTRan.InvtID, POTRan.SiteID, POTRan.WhseLoc, SPACE(25),
	POTRan.Qty, POTRan.CnvFact, POTRan.UnitMultDiv
	FROM	POReceipt (NOLOCK)
	JOIN	POTran (NOLOCK)
	ON	POReceipt.RcptNbr = POTRan.RcptNbr
	WHERE	POReceipt.BatNbr = @BatNbr
		AND POReceipt.RcptNbr LIKE @RcptNbr
		AND POReceipt.Rlsed = 0 AND POTran.PurchaseType IN ('GI','PI')
		AND POTran.TranType = 'X'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LoadAlloc_POTran] TO [MSDSL]
    AS [dbo];

