 Create Proc ADG_LoadAlloc_BOMTran
	@CpnyID		Varchar(10),
	@RefNbr		Varchar(10)
As

SELECT	LineRef, CmpnentID, SiteID, WhseLoc, SPACE(25),
	CmpnentQty, CONVERT(FLOAT,1), 'M'
	FROM	BOMTran (NOLOCK)
	WHERE	CpnyID = @CpnyID
		AND RefNbr = @RefNbr
		AND CmpnentQty > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LoadAlloc_BOMTran] TO [MSDSL]
    AS [dbo];

