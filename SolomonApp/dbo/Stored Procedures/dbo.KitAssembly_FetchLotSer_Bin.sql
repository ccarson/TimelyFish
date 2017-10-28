 create proc KitAssembly_FetchLotSer_Bin
	@InvtID 	varchar(30),
	@SiteID 	varchar(10),
	@PickMthd	varchar(1)
as

	Select	l.WhseLoc,
		--l.LotSerNbr,
		'QtyAvail' = (l.QtyAvail)

	From	LotSerMst l
	Join	LocTable  lt
	  on	l.SiteID = lt.SiteID
	  and	l.WhseLoc = lt.WhseLoc
	Join	ItemSite  s
	  on	s.InvtID = l.InvtID
	  and	s.SiteID = l.SiteID

	Where 	l.InvtID = @InvtID
	  and	l.SiteID = @SiteID
          and   lt.AssemblyValid = 'Y'
	  and	(l.QtyAvail) > 0

	Order By	-- Cases have to be grouped by data type
		Case @PickMthd
	           When 'E'	-- Expiration
			Then l.ExpDate

	           When 'F'	-- FIFO
			Then l.RcptDate
		End,

		Case @PickMthd
	           When 'L'	-- LIFO
			Then DateDiff(Day, l.RcptDate, GetDate())
		End,

		Case @PickMthd
	           When 'S'	-- Sequential
			Then l.LotSerNbr
		End,

		Case When s.DfltPickBin = l.WhseLoc Then 0 Else 1 End,
		lt.PickPriority,
		QtyAvail


