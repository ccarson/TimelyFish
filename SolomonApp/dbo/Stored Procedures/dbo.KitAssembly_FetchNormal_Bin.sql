 create proc KitAssembly_FetchNormal_Bin
	@InvtID varchar(30),
	@SiteID varchar(10)
as
	Select	l.WhseLoc,
	--	'LotSerNbr' = space(25),
		'QtyAvail' = (l.QtyAvail)

	From 	Location  l
	Join 	LocTable  lt
	  on	l.SiteID = lt.SiteID
	  and	l.WhseLoc = lt.WhseLoc
	Join	ItemSite  s
	  on	s.InvtID = l.InvtID
	  and	s.SiteID = l.SiteID

	Where 	l.InvtID = @InvtID
	  and 	l.SiteID = @SiteID
          and   lt.AssemblyValid = 'Y'
	  and	(l.QtyAvail) > 0

	Order By
		Case When s.DfltPickBin = l.WhseLoc Then 0 Else 1 End,
		lt.PickPriority,
		QtyAvail


