 create proc PO_BINLOTSER_FETCHLOTSER
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@PickMthd	varchar(1),
	@WhseLoc	varchar(10),
	@ETADate	smalldatetime,
	@BypassAlloc	smallint = 1,
	@OrdNbr     VarChar(15), 
	@CpnyID VarChar(10), 
	@LineRef VarChar(5), 
	@SchedRef VarChar(5)
as

-- -------------------------------------------------------------------
-- Fetch bin quantities for a lot- or serial-controlled item.
-- Fetch them in this Order
--   1. Purchase Order tied to Sales Order Lot/Serial Numbers first
--   2. All other Lot/Serial numbers by there valuation method.
-- -------------------------------------------------------------------

	declare	@Today	smalldatetime
	set	@Today = cast(floor(cast(getdate() as float)) as smalldatetime)

    SELECT l.WhseLoc,
           l.LotSerNbr,
           l.MfgrLotSerNbr,
           'QtyAvail' = (l.QtyAvail)

      FROM LotSerMst l join LocTable lt
                         ON l.SiteID = lt.SiteID
                        AND l.WhseLoc = lt.WhseLoc
                       LEFT JOIN VP_PurchOrd_TiedTo_SalesOrd v 
                         ON v.InvtID = l.InvtID        
                        AND v.SiteID = l.SiteID
                        AND v.WhseLoc = l.WhseLoc
                        AND v.LotSerNbr = l.LotSerNbr
                        AND v.SOOrdNbr = @OrdNbr
                        AND v.CpnyID = @CpnyID
                        AND v.SOLineRef = @LineRef
                        AND v.SOSchedRef = @SchedRef

     WHERE l.InvtID = @InvtID
       AND l.SiteID = @SiteID
       AND (@WhseLoc = '' or l.WhseLoc = @WhseLoc)
       AND lt.InclQtyAvail = 1
       AND l.Status = 'A'
       AND (l.QtyAvail + l.QtyAlloc * (1-@BypassAlloc) + l.QtyAllocSO * (1-@BypassAlloc)) > 0
       AND ((@PickMthd <> 'E') or ((@PickMthd = 'E') and (@ETADate <= l.ExpDate)))

     ORDER BY	-- Cases have to be grouped by data type
        CASE WHEN ISNULL(v.POExistOrder,0) > 0 
             THEN 0 
             ELSE 1 END, 
                     
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


