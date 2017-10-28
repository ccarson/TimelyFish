 Create Proc ADG_LoadAlloc_POLotSerT
	@BatNbr		Varchar(10),
	@RcptNbr	Varchar(10),
	@INTranLineRef	Varchar(5)
As

SELECT	INTranLineRef, InvtID, SiteID, WhseLoc, LotSerNbr,
	Qty, CONVERT(FLOAT,1), 'M'
	FROM	LotSerT (NOLOCK)
	WHERE	BatNbr = @BatNbr
		AND RefNbr = @RcptNbr
		AND Rlsed = 0 AND INTranLineRef = @INTranLineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LoadAlloc_POLotSerT] TO [MSDSL]
    AS [dbo];

