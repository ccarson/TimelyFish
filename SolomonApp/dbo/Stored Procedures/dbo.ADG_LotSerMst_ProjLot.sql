

CREATE PROCEDURE ADG_LotSerMst_ProjLot
    @ProjectID  varchar (16),
    @TaskID     varchar (32),	
    @InvtID		varchar (30),
    @SiteID 	varchar (10),
    @LotSerNbr	varchar (25)
	AS
-- ===================================================================
-- ADG_LotSerMst_LotSerNbr_NoAst.sql
-- Get all of the Lot or Serial Numbers given the SiteID and
-- InventoryID but exclude any data with an asterick
-- ===================================================================
    SELECT  LotSerMst.LotSerNbr, LotSerMst.WhseLoc, LotSerMst.QtyOnHand, ISNULL(VPLot.Qty,0) ProjQty
      FROM  LotSerMst INNER JOIN LocTable lt
                         ON lt.SiteID = LotSerMst.SiteID AND lt.WhseLoc = LotSerMst.WhseLoc
                      Left Join V_Plot  VPLot
                           ON LotSerMst.InvtId = VPLot.Invtid
                           AND LotSerMst.SiteId = VPLot.SiteId
                           AND LotSerMst.WhseLoc = VPLot.WhseLoc
                          AND LotSerMst.LotSerNbr = VPLot.LotSerNbr
                          AND VPlot.Projectid = @ProjectID
                          And VPLot.Taskid = @TaskId
     WHERE  LotSerMst.InvtID like @InvtID
       AND  LotSerMst.SiteID like @SiteID
       AND  lt.SalesValid <> 'N'
       AND  LotSerMst.LotSerNbr like @LotSerNbr
       AND  LotSerMst.Status = 'A'
       AND  LotSerMst.LotSerNbr <> '*'
       AND  (LotSerMst.QtyAvail) + ISNULL(VPLot.Qty,0) > 0
     ORDER BY LotSerMst.LotSerNbr

