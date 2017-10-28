 create proc ProjInv_CreateShipper_GetLotQtyAll
	@InvtID	varchar(30),
	@SiteID	varchar(10),
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as
    SELECT sum(l.QtyAvail + ISNULL(x.ProjInvAvail,0))
      FROM LotSerMst l JOIN LocTable lt
                         ON lt.SiteID = l.SiteID
                        AND lt.WhseLoc = l.WhseLoc
                       LEFT JOIN VP_PI_LotQtyByWhs x
                         ON l.InvtID = x.InvtID
                        AND l.SiteID = x.SiteID
                        AND l.WhseLoc = x.WhseLoc
                        AND l.LotSerNbr = x.LotSerNbr
                        AND x.ProjectID = @ProjectID
                        AND x.TaskID = @TaskID
                        AND l.QtyAllocProjIN > 0
    WHERE l.InvtID = @InvtID
      AND l.SiteID = @SiteID
      AND lt.InclQtyAvail = 1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_CreateShipper_GetLotQtyAll] TO [MSDSL]
    AS [dbo];

