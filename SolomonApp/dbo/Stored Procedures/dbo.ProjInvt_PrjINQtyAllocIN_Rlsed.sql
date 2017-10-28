 create proc ProjInvt_PrjINQtyAllocIN_Rlsed
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10)

AS
          UPDATE LotSerMst
             SET PrjINQtyAllocIN = COALESCE(D.PrjINQtyAllocIN,0)
            FROM LotSerMst LEFT JOIN (SELECT i.InvtID,
                                             i.LotSerNbr,
                                             i.SiteID,
                                             i.WhseLoc,
                                             SUM(i.QtyAllocated) as PrjINQtyAllocIN
                                        FROM INPrjAllocationLot i JOIN INTran t
                                                                    ON i.SrcNbr = t.RefNbr
                                                                   AND i.SrcLineRef = t.LineRef
                                                                   AND i.InvtID = t.InvtID
                                                                   AND i.SiteID = t.SiteID
                                       WHERE i.InvtID = @InvtID
                                         AND i.SiteID = @SiteID
                                         AND i.WhseLoc = @WhseLoc
                                         AND i.SrcType = 'IS'
                                         AND i.LotSerNbr <> ' '    
                                         AND t.Rlsed = 0
                                         AND t.TranType = 'II'      
                                       GROUP BY i.InvtID, i.SiteID, i.WhseLoc, i.LotSerNbr) as D

                            ON D.InvtID = LotSerMst.InvtID
                           AND	D.LotSerNbr = LotSerMst.LotSerNbr
                           AND	D.SiteID = LotSerMst.SiteID
                           AND	D.WhseLoc = LotSerMst.WhseLoc
          WHERE LotSerMst.InvtID = @InvtID
            AND LotSerMst.SiteID = @SiteID
            AND LotSerMst.WhseLoc = @WhseLoc
if @@error != 0 return(@@error)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInvt_PrjINQtyAllocIN_Rlsed] TO [MSDSL]
    AS [dbo];

