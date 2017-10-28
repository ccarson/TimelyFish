 CREATE PROC ProjectInventory_QtyAvail
	@InvtID		varchar(30),
	@SiteID		varchar(10)
 AS
-- Get Project Inventory less Project Inventory already on a Shipper and Sales Orders with Project Allocated Lots entered.
  SELECT i.InvtID, i.SiteID, (Sum(i.QtyRemaintoIssue) - COALESCE(d.QtyAllocated,0) - COALESCE(lots.LotQtyAllocated,0) - COALESCE(iss.IssueQtyAlloc,0) - COALESCE(rtn.ReturnQtyAlloc,0)) QtyAvailWOPrjInv 
    FROM InvProjAlloc i WITH(NOLOCK) LEFT JOIN (SELECT SUM(a.QtyAllocated) QtyAllocated, a.InvtID, a.SiteID
                                                  FROM InPrjAllocation a WITH(NOLOCK)
                                                 WHERE a.InvtID = @InvtID
                                                   AND a.SiteID = @SiteID
                                                   AND a.SrcType IN ('SH')
                                                 GROUP BY a.InvtID, a.SiteID) d
                                       ON i.InvtID = d.InvtID
                                      AND i.SiteID = d.SiteID
                                     LEFT JOIN (SELECT SUM(l.QtyAllocated) LotQtyAllocated, l.InvtID, l.SiteID
                                                  FROM INPrjAllocationLot l WITH(NOLOCK)
                                                 WHERE l.InvtID = @InvtID
                                                   AND l.SiteID = @SiteID
                                                   AND l.SrcType IN ('SO') 
                                                 GROUP BY l.InvtID, l.SiteID) as lots
                                      ON i.InvtID = lots.InvtID
                                     AND i.SiteID = lots.SiteID
                                     LEFT JOIN (SELECT SUM(a.QtyAllocated) IssueQtyAlloc, a.InvtID, a.SiteID
                                                  FROM InPrjAllocation a WITH(NOLOCK)
                                                 WHERE a.InvtID = @InvtID
                                                   AND a.SiteID = @SiteID
                                                   AND a.SrcType IN ('IS')
                                                 GROUP BY a.InvtID, a.SiteID) iss
                                       ON i.InvtID = iss.InvtID
                                      AND i.SiteID = iss.SiteID
                                      LEFT JOIN (SELECT SUM(a.QtyAllocated) ReturnQtyAlloc, a.InvtID, a.SiteID
                                                  FROM InPrjAllocation a WITH(NOLOCK)
                                                 WHERE a.InvtID = @InvtID
                                                   AND a.SiteID = @SiteID
                                                   AND a.SrcType IN ('RN')
                                                 GROUP BY a.InvtID, a.SiteID) as rtn
                                       ON i.InvtID = rtn.InvtID
                                      AND i.SiteID = rtn.SiteID
   WHERE i.InvtID = @InvtID
     AND i.SiteID = @SiteID
   GROUP BY i.InvtID, i.SiteID,d.QtyAllocated, lots.LotQtyAllocated, iss.IssueQtyAlloc, rtn.ReturnQtyAlloc


