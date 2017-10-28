
CREATE PROC ProjectInventory_QtyAvail_Lot
	@InvtID		varchar(30),
	@SiteID		varchar(10),
    @LotSerNbr VarChar(25),
    @WhseLoc VarChar(10),
    @RefNbr VarChar(15),
    @LineRef VarChar(5)
 AS
-- Get Project Inventory less Project Inventory already on a Shipper and Sales Orders with Project Allocated Lots entered.
  SELECT (Sum(i.QtyRemaintoIssue) - COALESCE(lots.LotQtyAllocated,0))  
    FROM InvProjAllocLot i WITH(NOLOCK) LEFT JOIN (SELECT SUM(l.QtyAllocated) LotQtyAllocated, l.InvtID, l.SiteID, l.LotSerNbr, l.WhseLoc
                                                  FROM INPrjAllocationLot l WITH(NOLOCK)
                                                 WHERE l.InvtID = @InvtID
                                                   AND l.SiteID = @SiteID
                                                   AND l.LotSerNbr = @LotSerNbr
                                                   AND l.WhseLoc = @WhseLoc
                                                   AND l.SrcType IN ('SO', 'SH', 'IS', 'RN') 
                                                   AND l.SrcNbr <> @RefNbr
                                                   AND l.SrcLineRef <> @LineRef
                                                 GROUP BY l.InvtID, l.SiteID, l.LotSerNbr, l.WhseLoc) as lots
                                      ON i.InvtID = lots.InvtID
                                     AND i.SiteID = lots.SiteID
                                     AND i.LotSerNbr = lots.LotSerNbr
                                     aND i.WhseLoc = lots.WhseLoc
   WHERE i.InvtID = @InvtID
     AND i.SiteID = @SiteID
     AND i.LotSerNbr = @LotSerNbr
     AND i.Whseloc = @WhseLoc
   GROUP BY i.InvtID, i.SiteID, lots.LotQtyAllocated, i.LotSerNbr, i.WhseLoc
