 Create Proc ADG_GetQtyOnHand_LotSerMst
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@LotSerNbr	Varchar(25)
As

SELECT	QtyOnHand
	FROM	LotSerMst (NOLOCK)
	WHERE	InvtID = @InvtID AND SiteID = @SiteID AND WhseLoc = @WhseLoc AND LotSerNbr = @LotSerNbr


