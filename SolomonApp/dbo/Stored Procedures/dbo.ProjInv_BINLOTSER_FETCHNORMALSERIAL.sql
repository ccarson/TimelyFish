 create proc ProjInv_BINLOTSER_FETCHNORMALSERIAL
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@BypassAlloc	smallint = 1,
	@QtyShip	float,
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as
     SELECT l.WhseLoc,
            'LotSerNbr' = space(25),
            'MfgrLotSerNbr' = space(25),
            'QtyAvail' = ((l.QtyAvail)  + @QtyShip + ISNULL(x.ProjInvAvail,0)),
            'ProjInvQtyAvail' = ISNULL(x.ProjInvAvail,0)

       FROM	Location l JOIN LocTable lt
                         ON l.SiteID = lt.SiteID
                        AND	l.WhseLoc = lt.WhseLoc
                       LEFT JOIN VP_PI_QtyLeftByWhs x
                         ON l.InvtID = x.InvtID
                        AND l.SiteID = x.SiteID
                        AND l.Whseloc = x.Whseloc
                        AND x.ProjectID = @ProjectID
                        AND x.TaskID = @TaskID

      WHERE l.InvtID = @InvtID
        AND	l.SiteID = @SiteID
        AND	lt.InclQtyAvail = 1
        AND	(((l.QtyAvail + l.QtyAlloc * (1-@BypassAlloc) + l.QtyAllocSO * (1-@BypassAlloc) + ISNULL(x.ProjInvAvail,0)) > 0)
			OR (ISNULL(x.ProjInvAvail,0) > 0))

       ORDER BY CASE WHEN ProjInvAvail > 0 
                       THEN 0 
                     ELSE 1 END,
                lt.PickPriority,
                QtyAvail



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_BINLOTSER_FETCHNORMALSERIAL] TO [MSDSL]
    AS [dbo];

