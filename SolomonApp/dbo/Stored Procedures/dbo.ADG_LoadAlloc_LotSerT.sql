 Create Proc ADG_LoadAlloc_LotSerT
	@BatNbr		Varchar(10),
	@INTranLineRef	Varchar(5),
	@RefNbr		Varchar(15) = '%'
As

SELECT	INTranLineRef, InvtID, SiteID, WhseLoc, LotSerNbr,
	-InvtMult*Qty, CONVERT(FLOAT,1), 'M'
	FROM	LotSerT (NOLOCK)
	WHERE	BatNbr = @BatNbr AND RefNbr LIKE @RefNbr
		AND Rlsed = 0 AND INTranLineRef = @INTranLineRef


