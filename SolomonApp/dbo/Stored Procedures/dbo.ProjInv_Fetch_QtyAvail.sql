create proc ProjInv_Fetch_QtyAvail
	@InvtID		varchar(30),
	@SiteID		varchar(10),
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as
    SELECT ProjInvAvail 
      FROM VP_PI_QtyRemaining
     WHERE InvtID = @InvtID
       AND SiteID = @SiteID
       AND ProjectID = @ProjectID
       AND TaskID = @TaskID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_Fetch_QtyAvail] TO [MSDSL]
    AS [dbo];

