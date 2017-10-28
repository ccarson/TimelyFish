 CREATE PROCEDURE ADG_LotSerMst_LotSerNbr_NoAst
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@LotSerNbr	varchar (25)
	AS
-- ===================================================================
-- ADG_LotSerMst_LotSerNbr_NoAst.sql
-- Get all of the Lot or Serial Numbers given the SiteID and
-- InventoryID but exclude any data with an asterick
-- ===================================================================
    SELECT  LotSerMst.LotSerNbr, LotSerMst.WhseLoc, QtyOnHand
      FROM  LotSerMst INNER JOIN LocTable lt
                         ON lt.SiteID = LotSerMst.SiteID AND lt.WhseLoc = LotSerMst.WhseLoc
     WHERE  LotSerMst.InvtID like @InvtID
       AND  LotSerMst.SiteID like @SiteID
       AND  lt.SalesValid <> 'N'
       AND  LotSerNbr like @LotSerNbr
       AND  LotSerMst.Status = 'A'
       AND  LotSerNbr <> '*'
       AND  (QtyAvail) > 0
     ORDER BY LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_LotSerMst_LotSerNbr_NoAst] TO [MSDSL]
    AS [dbo];

