 create proc ProjInv_CreateShipper_GetBinQtyAll
	@InvtID	varchar(30),
	@SiteID	varchar(10),
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as

    SELECT sum(l.QtyAvail + ISNULL(x.ProjInvAvail,0))
      FROM Location l JOIN LocTable  lt
                        ON lt.SiteID = l.SiteID
                       AND lt.WhseLoc = l.WhseLoc
                      LEFT JOIN VP_PI_QtyLeftByWhs x
                        ON l.InvtID = x.InvtID
                       AND l.SiteID = x.SiteID
                       AND l.Whseloc = x.Whseloc
                       AND x.ProjectID = @ProjectID
                       AND x.TaskID = @TaskID
     WHERE l.InvtID = @InvtID
       AND l.SiteID = @SiteID
       AND lt.InclQtyAvail = 1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_CreateShipper_GetBinQtyAll] TO [MSDSL]
    AS [dbo];

