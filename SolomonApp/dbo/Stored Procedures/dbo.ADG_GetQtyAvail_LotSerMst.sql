 Create Proc ADG_GetQtyAvail_LotSerMst
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@LotSerNbr	Varchar(25)
As

SELECT	SUM(QtyAvail)
	FROM	LotSerMst (NOLOCK)
	WHERE	InvtID = @InvtID AND SiteID = @SiteID AND WhseLoc LIKE @WhseLoc AND LotSerNbr LIKE @LotSerNbr


