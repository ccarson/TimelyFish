 CREATE PROCEDURE INLotSerMsT_InvtID_LotSerNbr_Filter
	@InvtID          varchar( 30 ),
	@SiteID          varchar( 10 ),
	@WhseLoc         varchar( 10 ),
   @LotSerNbr       varchar( 25 ),
	@MfgrLotSerNbr   varchar( 25 )

AS
	SELECT           *
	FROM             LotSerMst
	WHERE            InvtID = @InvtID and
	                 SiteID LIKE @SiteID and
	                 WhseLoc LIKE @WhseLoc and
	                 LotSerNbr LIKE @LotSerNbr and
	                 MfgrLotSerNbr LIKE @MfgrLotSerNbr
	ORDER BY         LotSerNbr, SiteID, WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INLotSerMsT_InvtID_LotSerNbr_Filter] TO [MSDSL]
    AS [dbo];

