Create Proc ADG_GetQtyRemainToIssue
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10),
	@LotSerNbr	Varchar(25),
    @SrcNbr     VarChar(15),
    @SrcLineref  VarChar (5)
AS
Select QtyRemainToIssue from InvProjAllocLot (nolock) where InvtiD = @InvtId AND SiteID = @SiteId AND WhseLoc = @WhseLoc AND LotSerNbr = @LotSerNbr 
AND SrcNbr = @SrcNbr AND SrcLineRef = @SrcLineRef

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetQtyRemainToIssue] TO [MSDSL]
    AS [dbo];

