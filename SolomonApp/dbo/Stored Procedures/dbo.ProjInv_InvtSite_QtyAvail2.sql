create proc ProjInv_InvtSite_QtyAvail2
	@InvtID		varchar(30),
	@SiteID		varchar(10)

as
    SELECT p.InvtID, p.SiteID, p.WhseLoc, p.ProjectID, p.TaskID, (p.ProjInvAvail - ISNULL(l.QtyAllocated,0)) ProjInvAvail
      FROM VP_PI_QtyLeftByWhs p WITH(NOLOCK) LEFT JOIN VP_InPrjAllocationLot_byWhse l WITH(NOLOCK)
                                               ON p.InvtID = l.InvtID
                                              AND p.SiteID = l.SiteID
                                              AND p.ProjectID = l.ProjectID
                                              AND p.TaskID = l.TaskID
                                              AND p.WhseLoc = l.Whseloc
     WHERE p.InvtID = @InvtID
       AND p.SiteID = @SiteID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_InvtSite_QtyAvail2] TO [MSDSL]
    AS [dbo];

