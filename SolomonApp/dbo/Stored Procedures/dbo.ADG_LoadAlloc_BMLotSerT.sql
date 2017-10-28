 Create Proc ADG_LoadAlloc_BMLotSerT
	@BatNbr		Varchar(10),
	@RefNbr		Varchar(10),
	@INTranLineRef	Varchar(5)
As

SELECT	INTranLineRef, InvtID, SiteID, WhseLoc, LotSerNbr,
	Qty, CONVERT(FLOAT,1), 'M'
	FROM	LotSerT (NOLOCK)
	WHERE	BatNbr = @BatNbr
		AND RefNbr = @RefNbr
		AND Rlsed = 0 AND INTranLineRef = @INTranLineRef


