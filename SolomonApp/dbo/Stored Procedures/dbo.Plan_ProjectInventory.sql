 CREATE PROCEDURE Plan_ProjectInventory
	@ComputerName	VarChar(21),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@DecPlQty	SmallInt
AS
	SET NOCOUNT ON

	/* Update the Quantity on Purchase Orders and the Quantity on Drop Shipments into ItemSite for the current
	InvtID and SiteID. */

    UPDATE ItemSite
       SET QtyAllocProjIN = Coalesce(D.QtyRemainToIssue,0),		
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM ItemSite JOIN INUpdateQty_Wrk INU WITH(NOLOCK)
                      ON INU.InvtID = ItemSite.InvtID					
                     AND INU.SiteID = ItemSite.SiteID					
                     AND INU.ComputerName + '' LIKE @ComputerName
                    LEFT JOIN (SELECT i.InvtID, i.SiteID,
			                           Round(Sum(i.QtyRemainToIssue),@DecPlQty) AS QtyRemainToIssue				
                                 FROM	InvProjAlloc i WITH(NOLOCK)
                                WHERE	i.SrcType IN ('GSO','PIA','POR','PRR','ISS')
                                GROUP BY i.InvtID, i.SiteID) AS D
                      ON 	D.InvtID = INU.InvtID					
                     AND 	D.SiteID = INU.SiteID


    UPDATE Location
       SET QtyAllocProjIN = Coalesce(D.QtyRemainToIssue,0),		
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM Location JOIN INUpdateQty_Wrk INU WITH(NOLOCK)
                      ON INU.InvtID = Location.InvtID					
                     AND INU.SiteID = Location.SiteID					
                     AND INU.ComputerName + '' LIKE @ComputerName
                    LEFT JOIN (SELECT i.InvtID, i.SiteID, i.Whseloc,
			                           Round(Sum(i.QtyRemainToIssue),@DecPlQty) AS QtyRemainToIssue				
                                 FROM	InvProjAlloc i WITH(NOLOCK)
                                WHERE	i.SrcType IN ('GSO','PIA','POR','PRR','ISS')
                                GROUP BY i.InvtID, i.SiteID, i.Whseloc) AS D
                      ON D.InvtID = INU.InvtID					
                     AND D.SiteID = INU.SiteID
                     AND D.Whseloc = Location.Whseloc


    UPDATE LotSerMst
       SET QtyAllocProjIN = Coalesce(D.QtyRemainToIssue,0),		
           LUpd_DateTime = GetDate(),
           LUpd_Prog = @LUpd_Prog,
           LUpd_User = @LUpd_User
      FROM LotSerMst JOIN INUpdateQty_Wrk INU WITH(NOLOCK)
                      ON INU.InvtID = LotSerMst.InvtID					
                     AND INU.SiteID = LotSerMst.SiteID					
                     AND INU.ComputerName + '' LIKE @ComputerName
                    LEFT JOIN (SELECT i.InvtID, i.SiteID, i.Whseloc, i.LotSerNbr,
			                           Round(Sum(i.QtyRemainToIssue),@DecPlQty) AS QtyRemainToIssue				
                                 FROM	InvProjAllocLot i WITH(NOLOCK)
                                WHERE	i.SrcType IN ('GSO','PIA','POR','PRR','RFI')
                                GROUP BY i.InvtID, i.SiteID, i.Whseloc, i.LotSerNbr) AS D
                      ON D.InvtID = INU.InvtID					
                     AND D.SiteID = INU.SiteID
                     AND D.Whseloc = LotSerMst.Whseloc
                     AND D.LotSerNbr = LotSerMst.LotSerNbr

