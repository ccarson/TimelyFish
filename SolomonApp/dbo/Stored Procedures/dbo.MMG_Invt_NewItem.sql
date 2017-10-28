 create proc MMG_Invt_NewItem
	@InvtID        char (30),
	@SiteID        char (10),
	@WhseLoc       char (10),	-- can be empty
	@LotSerNbr     char (25),	-- can be empty
   	@ProgID        varchar (8),
   	@UserID        varchar (10),
   	@Source        char (2),   -- source module setting up
   	@ErrorCode     smallint OUTPUT
as
set nocount on

	declare	@CpnyID	varchar(10)

	select	@CpnyID = CpnyID
	from	Site
	where	SiteID = @SiteID

	select @CpnyID = coalesce(@CpnyID, '')

   select @ErrorCode = 0

	-- ItemSite

	-- LeadTime = 999 to make it obvious that it needs to be fixed
	INSERT ItemSite (
		ABCCode,	AllocQty,	AvgCost,	BMIAvgCost,	BMIDirStdCst,	BMIFovhStdCst,
		BMILastCost,	BMIPDirStdCst,	BMIPFOvhStdCst,	BMIPStdCst,	BMIPVOvhStdCst,	BMIStdCost,
		BMITotCost,	BMIVOvhStdCst,	Buyer,		COGSAcct,	COGSSub,	CountStatus,
		CpnyID,		Crtd_DateTime,	Crtd_Prog,	Crtd_User,	CycleID,	DfltPOUnit,
		DfltSOUnit,	DirStdCst,	EOQ,		FOvhStdCst,	InvtAcct,	InvtID,
		InvtSub,	LastBookQty,	LastCost,	LastCountDate,	LastPurchaseDate, LastPurchasePrice,
		LastStdCost,	LastVarAmt,	LastVarPct,	LastVarQty,	LastVendor,	LeadTime,
		LUpd_DateTime,	LUpd_Prog,	LUpd_User,	MaxOnHand,	MfgLeadTime,	MoveClass,	NoteID,		PDirStdCst,
		PFOvhStdCst,	PrimVendID,	ProdMgrID,	PStdCostDate,	PStdCst,	PVOvhStdCst,
		QtyAlloc,	QtyAvail,	QtyCustOrd,	QtyInTransit,	QtyNotAvail,	QtyOnBO,
		QtyOnDP,	QtyOnHand,	QtyOnKitAssyOrders, QtyOnPO,	QtyOnTransferOrders, QtyShipnotInv,
		QtyWOFirmDemand,QtyWOFirmSupply,QtyWORlsedDemand,QtyWORlsedSupply,ReordInterval,ReordPt,
		ReordPtCalc,	ReordQty,	ReordQtyCalc,	ReplMthd,	S4Future01,	S4Future02,
		S4Future03,	S4Future04,	S4Future05,	S4Future06,	S4Future07,	S4Future08,
		S4Future09,	S4Future10,	S4Future11,	S4Future12,	SafetyStk,	SafetyStkCalc,
		SalesAcct,	SalesSub,	SecondVendID,	Selected,	ShipNotInvAcct,	ShipNotInvSub,	SiteID,
		StdCost,	StdCostDate,	StkItem,	TotCost,	Turns,		UsageRate,
		User1,		User2,		User3,		User4,		User5,		User6,
		User7,		User8,		VOvhStdCst,	YTDUsage)
	select distinct
	     --	ABCCode,	AllocQty,	AvgCost,	BMIAvgCost,	BMIDirStdCst,	BMIFovhStdCst,
		ABCCode,	0,		0,		0,		BMIDirStdCost,	BMIFOvhStdCost,
	     --	BMILastCost,	BMIPDirStdCst,	BMIPFOvhStdCst,	BMIPStdCst,	BMIPVOvhStdCst,	BMIStdCost,
		BMILastCost,	BMIPDirStdCost,	BMIPFOvhStdCost,BMIPStdCost,	BMIPVOvhStdCost,BMIStdCost,
	     --	BMITotCost,	BMIVOvhStdCst,	Buyer,		COGSAcct,	COGSSub,	CountStatus,
		0,		BMIVOvhStdCost,	'',		COGSAcct,	COGSSub,	'A',
	     --	CpnyID,		Crtd_DateTime,	Crtd_Prog,	Crtd_User,	CycleID,	DfltPOUnit,
		@CpnyID,	GETDATE(),	@ProgID,	@UserID,	CycleID,	DfltPOUnit,
	     --	DfltSOUnit,	DirStdCst,	EOQ,		FOvhStdCst,	InvtAcct,	InvtID,
		DfltSOUnit,	DirStdCost,	0,		FOvhStdCost,	InvtAcct,	@InvtID,
	     --	InvtSub,	LastBookQty,	LastCost,	LastCountDate,	LastPurchaseDate, LastPurchasePrice,
		InvtSub,	0,		LastCost,	'',		'',		0,
	     --	LastStdCost,	LastVarAmt,	LastVarPct,	LastVarQty,	LastVendor,	LeadTime,
		0,		0,		0,		0,		'',		999,
	     --	LUpd_DateTime,	LUpd_Prog,	LUpd_User,	MaxOnHand,	MfgLeadTime, 	MoveClass,	NoteID,		PDirStdCst,
		GETDATE(),	@ProgID,	@UserID,	0,		MfgLeadTime,	MoveClass,	0,		PDirStdCost,
	     --	PFOvhStdCst,	PrimVendID,	ProdMgrID,	PStdCostDate,	PStdCst,	PVOvhStdCst,
		PFOvhStdCost,	Supplr1,	ProdMgrID,	PStdCostDate,	PStdCost,	PVOvhStdCost,
	     --	QtyAlloc,	QtyAvail,	QtyCustOrd,	QtyInTransit,	QtyNotAvail,	QtyOnBO,
		0,		0,		0,		0,		0,		0,
	     --	QtyOnDP,	QtyOnHand,	QtyOnKitAssyOrders, QtyOnPO,	QtyOnTransferOrders, QtyShipnotInv,
		0,		0,		0,		0,		0,		0,
	     -- QtyWOFirmDemand,QtyWOFirmSupply,QtyWORlsedDemand,QtyWORlsedSupply,ReordInterval,ReordPt,
		0,		0,		0,		0,		0,		0,
	     --	ReordPtCalc,	ReordQty,	ReordQtyCalc,	ReplMthd,	S4Future01,	S4Future02,
		0,		0,		0,		'Q',		'',		'',
	     --	S4Future03,	S4Future04,	S4Future05,	S4Future06,	S4Future07,	S4Future08,
		0,		0,		0,		0,		'',		'',
	     --	S4Future09,	S4Future10,	S4Future11,	S4Future12,	SafetyStk,	SafetyStkCalc,
		0,		0,		'',		'',		0,		0,
	     --	SalesAcct,	SalesSub,	SecondVendID,	Selected,	ShipNotInvAcct,	ShipNotInvSub,	SiteID,
		DfltSalesAcct,	DfltSalesSub,	'',		0,		DfltShpNotInvAcct, DfltShpNotInvSub, @SiteID,
	     --	StdCost,	StdCostDate,	StkItem,	TotCost,	Turns,		UsageRate,
		StdCost,	StdCostDate,	StkItem,	0,		0,		UsageRate,
	     --	User1,		User2,		User3,		User4,		User5,		User6,
		'',		'',		0,		0,		'',		'',
	     --	User7,		User8,		VOvhStdCst,	YTDUsage
		'',		'',		VOvhStdCost,	0
	from	Inventory
        where	InvtId = @InvtID
	  and	((@InvtID + @SiteID) not in (select InvtId + SiteId from ItemSite))

	if (@@error = 0)
		print 'ItemSite complete'
	else
	begin
		print 'ItemSite error'
		select @ErrorCode = 1
		goto FINISH
	end

	-- LocTable
	-- AssemblyValid = 'Y'
	-- InclQtyAvail = 1
	-- InvtIDValid = 'N'
	-- ReceiptsValid = 'Y'
	-- SalesValid = 'Y'
	if (rtrim(@WhseLoc) > '')
	begin
	insert	 LocTable
		(
		ABCCode, AssemblyValid, BinType, CountStatus,
		Crtd_DateTime, Crtd_Prog, Crtd_User, CycleID, Descr,
		InclQtyAvail, InvtId, InvtIdValid, LastBookQty,
		LastCountDate, LastVarAmt, LastVarPct, LastVarQty,
		LUpd_DateTime, LUpd_Prog, LUpd_User, MoveClass,
		NoteId, PickPriority, PutAwayPriority, ReceiptsValid,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		SalesValid, Selected, SiteId, User1, User2, User3,
		User4, User5, User6, User7, User8, WhseLoc
		)

	select distinct
		i.ABCCode, 'Y', '', 'A', GetDate(), @ProgID,
		@UserID, '', '', 1, '', 'N', 0,
		'', 0, 0, 0, GetDate(), @ProgID, @UserID,
		'', 0, 0, 0, 'Y', '', '', 0, 0, 0,
		0, '', '', 0, 0, '',
		'', 'Y', 0, @SiteId, '', '', 0, 0,
		'', '', '', '',
		@WhseLoc

	from	Site  s
	  left
	  join	ItemSite  i
	  on	i.InvtID = @InvtID
	  and	i.SiteID = @SiteID
	where	s.SiteID = @SiteID
	  and	((@SiteId + @WhseLoc) not in (select SiteId + WhseLoc from LocTable))

	if (@@error = 0)
		print 'LocTable complete'
	else
	begin
		print 'LocTable error'
		select @ErrorCode = 3
		goto FINISH
	end
	end

	-- Location
	-- CountStatus = 'A'
	if (rtrim(@WhseLoc) > '')
	begin
	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtId, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		QtyAlloc, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03,
		S4Future04, S4Future05, S4Future06, S4Future07,
		S4Future08, S4Future09, S4Future10, S4Future11,
		S4Future12, Selected, SiteId, User1, User2, User3,
		User4, User5, User6, User7, User8, WhseLoc
	)
	select distinct
		'A', GetDate(), @ProgID, @UserID, @InvtId, GetDate(),
		@ProgID, @UserID, 0,
		0, 0, 0, 0,
		'', '', 0, 0, 0,
		0, '', '', 0, 0, '', '', 0,
		@SiteId, '', '', 0, 0, '', '', '',
		'', @WhseLoc
	from	Inventory
	where	InvtID = @InvtID
	  and	((@InvtId + @SiteId + @WhseLoc) not in (select InvtId + SiteId + WhseLoc from Location))

	if (@@error = 0)
		print 'Location complete'
	else
	begin
		print 'Location error'
		select @ErrorCode = 5
		goto FINISH
	end
	end

	-- LotSerMst

   -- Source is passed via @Source
	-- Source was defaulted to 'OM' for Order Management (not used now)

	-- Status is defaulted to 'H' to put the lot/serial number on
	-- hold until it's costed (the status will be changed to 'A'
	-- (Available) at that time.

	if (rtrim(@LotSerNbr) > '') and (rtrim(@WhseLoc) > '')
	begin
			insert	LotSerMst
			(
				Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
				ExpDate, InvtID, LIFODate, LotSerNbr,
				LUpd_DateTime, LUpd_Prog, LUpd_User,
				MfgrLotSerNbr, NoteID, OrigQty, QtyAlloc,
				QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
	 			RcptDate, S4Future01,
				S4Future02, S4Future03, S4Future04,
				S4Future05, S4Future06, S4Future07,
				S4Future08, S4Future09, S4Future10,
				S4Future11, S4Future12, ShipContCode, SiteID,
				Source, SrcOrdNbr, Status, StatusDate, User1,
				User2, User3, User4, User5, User6, User7,
				User8, WarrantyDate, WhseLoc
			)
	    		select distinct
				0, GetDate(), @ProgID, @UserID, '', @InvtID,
				'', @LotSerNbr, GetDate(), @ProgID, @UserID,
				'', 0, 0, 0,
				0, 0, 0,
				'', '',  '', 0, 0, 0, 0,
				'', '', 0, 0,  '', '', '', @SiteID,  'OM', '',
				'H', '', '', '', 0, 0, '', '', '', '', '',
				@WhseLoc
		from	Inventory
   		where	InvtId = @InvtID
		  and	((@InvtID + @LotSerNbr + @SiteID + @WhseLoc)
		  not in
			(select InvtId + LotSerNbr + SiteId + WhseLoc from LotSerMst))

		if (@@error = 0)
		print 'LotSerMst complete'
		else
		begin
			print 'LotSerMst error'
			select @ErrorCode = 6
			goto FINISH
		end
	end

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[MMG_Invt_NewItem] TO [MSDSL]
    AS [dbo];

