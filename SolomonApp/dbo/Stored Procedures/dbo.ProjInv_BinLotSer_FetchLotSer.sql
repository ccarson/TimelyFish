 create proc ProjInv_BinLotSer_FetchLotSer
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@PickMthd	varchar(1),
	@WhseLoc	varchar(10),
	@ETADate	smalldatetime,
	@BypassAlloc	smallint = 1,
    @ProjectID VarChar(16),
    @TaskID VarChar(32)
as
-- ===================================================================
-- ADG_BinLotSer.sql - Stored procedures used by class ADGBinLotSer.
-- ===================================================================
-- -------------------------------------------------------------------
-- Fetch bin quantities for a lot- or serial-controlled item.
-- -------------------------------------------------------------------

	declare	@Today	smalldatetime
	set	@Today = cast(floor(cast(getdate() as float)) as smalldatetime)

    SELECT l.WhseLoc,
           l.LotSerNbr,
           l.MfgrLotSerNbr,
           'QtyAvail' = (l.QtyAvail + ISNULL(x.ProjInvAvail,0)),
           'ProjInvQtyAvail' = ISNULL(x.ProjInvAvail,0)

      FROM LotSerMst l JOIN LocTable lt
                         ON l.SiteID = lt.SiteID
                        AND l.WhseLoc = lt.WhseLoc
                       LEFT JOIN VP_PI_LotQtyByWhs x
                         ON l.InvtID = x.InvtID
                        AND l.SiteID = x.SiteID
                        AND l.LotSerNbr = x.LotSernbr
                        AND l.Whseloc = x.Whseloc
                        AND x.ProjectID = @ProjectID
                        AND x.TaskID = @TaskID

     WHERE l.InvtID = @InvtID
       AND l.SiteID = @SiteID
       AND (@WhseLoc = '' or l.WhseLoc = @WhseLoc)
       AND lt.InclQtyAvail = 1
       AND l.Status = 'A'
       AND (((l.QtyAvail + l.QtyAlloc * (1-@BypassAlloc) + l.QtyAllocSO * (1-@BypassAlloc) + ISNULL(x.ProjInvAvail,0)) > 0)
			OR (ISNULL(x.ProjInvAvail,0) > 0))
       AND ((@PickMthd <> 'E') or ((@PickMthd = 'E') and (@ETADate <= l.ExpDate)))

     ORDER BY CASE WHEN ProjInvAvail > 0 
                       THEN 0 
                     ELSE 1 END, 
    	-- Cases have to be grouped by data type
		case @PickMthd
			when 'E'	-- Expiration
				then l.ExpDate

			when 'F'	-- FIFO
				then l.RcptDate
		end,

		case @PickMthd
			when 'L'	-- LIFO
				then datediff(day, l.RcptDate, GetDate())
		end,

		case @PickMthd
			when 'S'	-- Sequential
				then l.LotSerNbr
		end,

		case @PickMthd
			when 'F'	-- FIFO
				then l.LotSerNbr
		end Asc,

		case @PickMthd
			when 'L'	-- LIFO
				then l.LotSerNbr
		end desc,

		lt.PickPriority,
		QtyAvail



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_BinLotSer_FetchLotSer] TO [MSDSL]
    AS [dbo];

