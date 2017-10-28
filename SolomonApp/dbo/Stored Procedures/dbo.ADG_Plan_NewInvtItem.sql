 create proc ADG_Plan_NewInvtItem
	@InvtID			varchar(30),
	@SiteID			varchar(10),
	@ProgID 		varchar(8),
	@UserID			varchar(10),
	@ProcessLotSer		smallint	-- logical
as
	set nocount on

	declare	@CpnyID		varchar(10)

	-- Get the company ID from the site
	select	@CpnyID = CpnyID
	from	Site (nolock)
	where	SiteID = @SiteID

	select @CpnyID = coalesce(@CpnyID, '')

	-- ------------------------------------------------------------
	-- LotSerMst
	-- ------------------------------------------------------------
	-- Source is defaulted to 'OM' for Order Management
	-- Status is defaulted to 'H' to put the lot/serial number on
	-- hold until it's costed (the status will be changed to 'A'
	-- (Available) at that time.
	if (@ProcessLotSer = 1)
	begin
		-- Create missing LotSerMst records based on plan/shipper information.
		insert	LotSerMst
		(
			Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
			ExpDate, InvtID, LIFODate, LotSerNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			MfgrLotSerNbr, NoteID, OrigQty, 
			PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv, QtyAlloc,
			QtyAllocProjIN, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand, RcptDate,
			S4Future01, S4Future02, S4Future03, S4Future04,
			S4Future05, S4Future06, S4Future07, S4Future08,
			S4Future09, S4Future10, S4Future11, S4Future12,
			ShipContCode, SiteID, Source, SrcOrdNbr, Status, StatusDate,
			User1, User2, User3, User4,
			User5, User6, User7, User8,
			WarrantyDate, WhseLoc
		)
		select
			0, getdate(), @ProgID, @UserID,
			'', @InvtID, '', L.LotSerNbr,
			getdate(), @ProgID, @UserID,
			'', 0, 0, 
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, '',
			'', '', 0, 0,
			0, 0, '', '',
			0, 0, '', '',
			'', @SiteID, 'OM', '', 'H', '',
			'', '', 0, 0,
			'', '', '', '',
			'', L.WhseLoc

	          FROM	(SELECT Distinct WhseLoc,LotSerNbr
                           FROM SOPlan P (NOLOCK)
	                   JOIN SOShipLot L WITH (NOLOCK)
	                     ON L.CpnyID = P.CpnyID
	                    AND L.ShipperID = P.SOShipperID
	                    AND L.LineRef = P.SOShipperLineRef

	                  WHERE	P.PlanType in ('26', '30', '32', '34')
	                    AND P.InvtID = @InvtID
	                    AND P.SiteID = @SiteID) L
                 WHERE not exists (	select	InvtID, SiteID, WhseLoc, LotSerNbr
			                  from	LotSerMst
				         where	InvtID = @InvtID
				           and	LotSerNbr = L.LotSerNbr
				           and	SiteID = @SiteID
				           and	WhseLoc = L.WhseLoc)

		insert	LotSerMst
		(
			Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
			ExpDate, InvtID, LIFODate, LotSerNbr,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			MfgrLotSerNbr, NoteID, OrigQty, 
			PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv, QtyAlloc,
			QtyAllocProjIN, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand, RcptDate,
			S4Future01, S4Future02, S4Future03, S4Future04,
			S4Future05, S4Future06, S4Future07, S4Future08,
			S4Future09, S4Future10, S4Future11, S4Future12,
			ShipContCode, SiteID, Source, SrcOrdNbr, Status, StatusDate,
			User1, User2, User3, User4,
			User5, User6, User7, User8,
			WarrantyDate, WhseLoc
		)
		select distinct
			0, getdate(), @ProgID, @UserID,
			'', @InvtID, '', L.LotSerNbr,
			getdate(), @ProgID, @UserID,
			'', 0, 0, 
			0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, '',
			'', '', 0, 0,
			0, 0, '', '',
			0, 0, '', '',
			'', @SiteID, 'OM', '', 'H', '',
			'', '', 0, 0,
			'', '', '', '',
			'', L.WhseLoc

		from	SOPlan P (NOLOCK)

		join	SOLot L (NOLOCK)
		on	L.CpnyID = P.CpnyID
		and	L.OrdNbr = P.SOOrdNbr
		and	L.LineRef = P.SOLineRef
		and	L.SchedRef = P.SOSchedRef

		where	P.PlanType in ('60', '61')	-- Order
		and	L.Status = 'O'
		and	P.InvtID = @InvtID
		and	P.SiteID = @SiteID
		and	not exists (	select	InvtID, SiteID, WhseLoc, LotSerNbr
					from	LotSerMst
					where	InvtID = @InvtID
					and	LotSerNbr = L.LotSerNbr
					and	SiteID = @SiteID
					and	WhseLoc = L.WhseLoc)

	end	-- if (@ProcessLotSer = 1)

	-- ------------------------------------------------------------
	-- Location
	-- ------------------------------------------------------------
	-- Even for lot/serial items, it seems faster to use the plan and shipper data
	-- (rather than roll up the LotSerMst data) despite the extra reads the statement
	-- can incur. This may make sense though because it is likely there will be less
	-- shippers in the plan at any given time than the total number of LotSerMst
	-- records that the statement has to search through otherwise.

	-- Create missing location records based on plan/shipper information.
	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv,
		QtyAlloc, QtyAllocProjIN, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, SiteID, User1, User2, User3, User4,
		User5, User6, User7, User8, WhseLoc
	)
	SELECT
		'A', getdate(), @ProgID, @UserID,
		@InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, @SiteID, '', '', 0, 0,
		'', '', '', '', L.WhseLoc

	  FROM	(SELECT Distinct WhseLoc
                   FROM SOPlan P (NOLOCK)
	                INNER LOOP JOIN SOShipLot L WITH (NOLOCK)
	                  ON L.CpnyID = P.CpnyID
	                 AND L.ShipperID = P.SOShipperID
	                 AND L.LineRef = P.SOShipperLineRef

	          WHERE	P.PlanType in ('26', '30', '32', '34')
	            AND P.InvtID = @InvtID
	            AND P.SiteID = @SiteID
	            AND L.WhseLoc <> '') L
         WHERE not exists (	select 	InvtID, SiteID, WhseLoc
				from	Location
				where	InvtID = @InvtID
				and	SiteID = @SiteID
				and	WhseLoc = L.WhseLoc)

	insert	Location
	(
		CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
		InvtID, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
		PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv,
		QtyAlloc, QtyAllocProjIN, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		Selected, SiteID, User1, User2, User3, User4,
		User5, User6, User7, User8, WhseLoc
	)
	select distinct
		'A', getdate(), @ProgID, @UserID,
		@InvtID, getdate(), @ProgID, @UserID, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		'', '', 0, 0,
		0, 0, '', '',
		0, 0, '', '',
		0, @SiteID, '', '', 0, 0,
		'', '', '', '', L.WhseLoc

	from	SOPlan P (NOLOCK)

	join	SOLot L  WITH (NOLOCK)
	on	L.CpnyID = P.CpnyID
	and	L.OrdNbr = P.SOOrdNbr
	and	L.LineRef = P.SOLineRef
	and	L.SchedRef = P.SOSchedRef

	where	P.PlanType in ('60', '61')	-- Order
	and	L.Status = 'O'

	and	P.InvtID = @InvtID
	and	P.SiteID = @SiteID
	and	L.WhseLoc <> ''
	and	not exists (	select	InvtID, SiteID, WhseLoc
				from	Location
				where	InvtID = @InvtID
				and	SiteID = @SiteID
				and	WhseLoc = L.WhseLoc)

	-- ------------------------------------------------------------
	-- LocTable
	-- ------------------------------------------------------------

	-- Create missing bin records based on the available location information.
	insert	LocTable
	(
		ABCCode, AssemblyValid, BinType, CountStatus,
		Crtd_DateTime, Crtd_Prog, Crtd_User, CycleID, Descr,
		InclQtyAvail, InvtID, InvtIDValid, LastBookQty,
		LastCountDate, LastVarAmt, LastVarPct, LastVarQty,
		LUpd_DateTime, LUpd_Prog, LUpd_User, MoveClass,
		NoteId, PickPriority, PutAwayPriority, ReceiptsValid,
		S4Future01, S4Future02, S4Future03, S4Future04,
		S4Future05, S4Future06, S4Future07, S4Future08,
		S4Future09, S4Future10, S4Future11, S4Future12,
		SalesValid, Selected, SiteID, User1, User2, User3,
		User4, User5, User6, User7, User8, WhseLoc
	)
	select distinct
		I.ABCCode, 'Y', '', 'A', getdate(), @ProgID,
		@UserID, '', '', 1, '', 'N', 0,
		'', 0, 0, 0, getdate(), @ProgID, @UserID,
		'', 0, 0, 0, 'Y', '', '', 0, 0, 0,
		0, '', '', 0, 0, '',
		'', 'Y', 0, @SiteID, '', '', 0, 0,
		'', '', '', '', L.WhseLoc

	from	Location L

	join	Inventory I (nolock)
	on	I.InvtID = L.InvtID

	where	L.InvtID = @InvtID
	and	L.SiteID = @SiteID
	and 	not exists (	select	SiteID, WhseLoc
				from	LocTable
				where	SiteID = @SiteID
				and	WhseLoc = L.WhseLoc)

	-- ------------------------------------------------------------
	-- ItemSite
	-- ------------------------------------------------------------
	-- Create missing item/site record based on inventory information.
	-- LeadTime is set to 999 to make it obvious that it needs to be fixed.
	insert	ItemSite
	(
		ABCCode, AllocQty, AvgCost, BMIAvgCost,
		BMIDirStdCst, BMIFovhStdCst, BMILastCost, BMIPDirStdCst,
		BMIPFOvhStdCst, BMIPStdCst, BMIPVOvhStdCst, BMIStdCost,
		BMITotCost, BMIVOvhStdCst, Buyer, COGSAcct,
		COGSSub, CountStatus, CpnyID, Crtd_DateTime,
		Crtd_Prog, Crtd_User, CycleID, DfltPOUnit,
		DfltSOUnit, DirStdCst, EOQ, FOvhStdCst,
		InvtAcct, InvtID, InvtSub, LastBookQty,
		LastCost, LastCountDate, LastPurchaseDate, LastPurchasePrice,
		LastStdCost, LastVarAmt, LastVarPct, LastVarQty,
		LastVendor, LeadTime, LUpd_DateTime, LUpd_Prog,
		LUpd_User, MaxOnHand, MfgLeadTime, MoveClass,
		NoteId, PDirStdCst, PFOvhStdCst, PrimVendID,
		ProdMgrID, PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyCustOrd, 
		PrjINQtyShipNotInv, PStdCostDate, PStdCst, PVOvhStdCst,
		QtyAlloc, QtyAllocProjIN, QtyAvail, QtyCustOrd, QtyInTransit,
		QtyNotAvail, QtyOnBO, QtyOnDP, QtyOnHand,
		QtyOnKitAssyOrders, QtyOnPO, QtyOnTransferOrders, QtyShipNotInv,
		QtyWOFirmDemand, QtyWOFirmSupply, QtyWORlsedDemand, QtyWORlsedSupply,
		ReordInterval, ReordPt, ReordPtCalc, ReordQty,
		ReordQtyCalc, ReplMthd, S4Future01, S4Future02,
		S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10,
		S4Future11, S4Future12, SafetyStk, SafetyStkCalc,
		SalesAcct, SalesSub, SecondVendID, Selected,
		ShipNotInvAcct, ShipNotInvSub, SiteID, StdCost,
		StdCostDate, StkItem, TotCost, Turns,
		UsageRate, User1, User2, User3,
		User4, User5, User6, User7,
		User8, VOvhStdCst, YTDUsage
	)
	select distinct
		ABCCode, 0, 0, 0,
		BMIDirStdCost, BMIFOvhStdCost, BMILastCost, BMIPDirStdCost,
		BMIPFOvhStdCost, BMIPStdCost, BMIPVOvhStdCost, BMIStdCost,
		0, BMIVOvhStdCost, '', COGSAcct,
		COGSSub, 'A', @CpnyID, getdate(),
		@ProgID, @UserID, CycleID, DfltPOUnit,
		DfltSOUnit, DirStdCost, 0, FOvhStdCost,
		InvtAcct, @InvtID, InvtSub, 0,
		0, '', '', 0,
		0, 0, 0, 0,
		'', 999, getdate(), @ProgID,
		@UserID, 0, 0, MoveClass,
		0, PDirStdCost, PFOvhStdCost, '',
		'', 0, 0, 0, 0, 0,
		0, PStdCostDate,PStdCost, PVOvhStdCost,
		0, 0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, '', '', '',
		0, 0, 0, 0,
		'', '', 0, 0,
		'', '', 0, 0,
		DfltSalesAcct, DfltSalesSub, '', 0,
		DfltShpNotInvAcct, DfltShpNotInvSub, @SiteID, StdCost,
		StdCostDate, StkItem, 0, 0,
		UsageRate, '', '', 0,
		0, '', '', '',
		'', VOvhStdCost, 0
	from	Inventory
	where	InvtID = @InvtID
	and	not exists (	select	InvtID, SiteID
				from	ItemSite
				where	InvtID = @InvtID
				and	SiteID = @SiteID)


