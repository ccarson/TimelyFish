 create proc DMG_BinLotSer_FetchLotSer
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@WhseLoc	varchar(10),
	@PickMthd	varchar(1)
as

	if @WhseLoc = '%'
	begin

		DECLARE @SqlStmt as varchar(500)

		select @SqlStmt =
		'select	l.WhseLoc,
			l.LotSerNbr,
			l.MfgrLotSerNbr,
			QtyAvail = (l.QtyAvail)

		from	LotSerMst l
		join	LocTable  lt
		on	l.SiteID = lt.SiteID and l.WhseLoc = lt.WhseLoc

		where 	l.InvtID = ' + QUOTENAME(@InvtID, '''') + '
		and	l.SiteID = ' + QUOTENAME(@SiteID, '''') + '
		and	lt.InclQtyAvail = 1
		and	(l.QtyAvail + l.QtyAllocPORet) > 0

		order by ' +
			Case @PickMthd
		           When 'E' Then 'l.ExpDate' 		-- Expiration
	        	   When 'F' Then 'l.RcptDate'		-- FIFO
		           When 'L' Then 'l.RcptDate desc'	-- LIFO
			   Else 'l.LotSerNbr'			-- Sequential
			End
			+ ',lt.PickPriority,QtyAvail'

		exec (@SqlStmt)

	end
	else
	begin
		if @PickMthd = 'E'	-- Expiration
				select	WhseLoc,
				LotSerNbr,
				MfgrLotSerNbr,
				QtyAvail = (QtyOnHand - QtyShipNotInv - QtyAlloc)
			from	LotSerMst
			where 	InvtID = @InvtID
			and	SiteID = @SiteID
			and	WhseLoc = @WhseLoc
			and	(QtyOnHand - QtyShipNotInv - QtyAlloc) > 0
			order by ExpDate, LotSerNbr
			else if @PickMthd = 'F'	-- FIFO
				select	WhseLoc,
				LotSerNbr,
				MfgrLotSerNbr,
				QtyAvail = (QtyOnHand - QtyShipNotInv - QtyAlloc)
			from	LotSerMst
			where 	InvtID = @InvtID
			and	SiteID = @SiteID
			and	WhseLoc = @WhseLoc
			and	(QtyOnHand - QtyShipNotInv - QtyAlloc) > 0
			order by RcptDate, LotSerNbr
			else if @PickMthd = 'L'	-- LIFO
				select	WhseLoc,
				LotSerNbr,
				MfgrLotSerNbr,
				QtyAvail = (QtyOnHand - QtyShipNotInv - QtyAlloc)
			from	LotSerMst
			where 	InvtID = @InvtID
			and	SiteID = @SiteID
			and	WhseLoc = @WhseLoc
			and	(QtyOnHand - QtyShipNotInv - QtyAlloc) > 0
			order by LIFODate desc, LotSerNbr desc
		else			-- All Others
			select	WhseLoc,
				LotSerNbr,
				MfgrLotSerNbr,
				QtyAvail = (QtyOnHand - QtyShipNotInv - QtyAlloc)
			from	LotSerMst
			where 	InvtID = @InvtID
			and	SiteID = @SiteID
			and	WhseLoc = @WhseLoc
			and	(QtyOnHand - QtyShipNotInv - QtyAlloc) > 0
			order by LotSerNbr
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_BinLotSer_FetchLotSer] TO [MSDSL]
    AS [dbo];

