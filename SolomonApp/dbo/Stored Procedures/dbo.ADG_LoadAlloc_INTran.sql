 Create Proc ADG_LoadAlloc_INTran
	@BatNbr		Varchar(10),
	@RefNbr		Varchar(15) = '%'
As

SELECT	LineRef, InvtID, SiteID, WhseLoc, SPACE(25),
	-InvtMult*Qty, CnvFact, UnitMultDiv
	FROM	INTran (NOLOCK)
	WHERE	BatNbr = @BatNbr AND RefNbr LIKE @RefNbr
		AND Rlsed = 0 AND S4Future09 = 0 AND SrcNbr = ''
		AND (TranType IN ('II','IN','DM','TR')
		OR TranType = 'AS' AND InvtMult = -1
		OR TranType = 'AJ' AND Qty < 0)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LoadAlloc_INTran] TO [MSDSL]
    AS [dbo];

