 CREATE PROCEDURE ADG_LotSerMst_LotSerNbr_All
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@LotSerNbr	varchar (25)
	AS
-- ===================================================================
-- ADG_LotSerMst_LotSerNbr_All.sql
-- Get all of the Lot or Serial Numbers given the SiteID and
-- InventoryID but exclude any data with an asterick
-- ===================================================================
    SELECT  LotSerNbr, WhseLoc, QtyOnHand
      FROM  LotSerMst
     WHERE  InvtID like @InvtID
       AND  SiteID like @SiteID
       AND  LotSerNbr like @LotSerNbr
       AND  LotSerNbr <> '*'
       AND  Status = 'A'
     ORDER BY LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMst_LotSerNbr_All] TO [MSDSL]
    AS [dbo];

