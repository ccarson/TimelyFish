create proc ProjInv_InvtSite_QtyAvail
	@InvtID		varchar(30),
	@SiteID		varchar(10)

as
    SELECT InvtID, SiteID, WhseLoc, ProjectID, TaskID, ProjInvAvail 
      FROM VP_PI_QtyLeftByWhs WITH(NOLOCK)
     WHERE InvtID = @InvtID
       AND SiteID = @SiteID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_InvtSite_QtyAvail] TO [MSDSL]
    AS [dbo];

