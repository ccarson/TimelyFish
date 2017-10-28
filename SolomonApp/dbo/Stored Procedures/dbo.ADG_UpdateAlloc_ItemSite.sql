 Create Proc ADG_UpdateAlloc_ItemSite
	@InvtID		Varchar(30),
	@SiteID		Varchar(10),
	@CpnyID		Varchar(10),
	@ProgID		Varchar(8),
	@UserID		Varchar(10),
	@OldBucket	smallint,
	@NewBucket	smallint,
	@OldAlloc	float,
	@NewAlloc	float
          
As

	declare	@WOOpt varchar (1)
    Declare @ProjInvtBeingIssued Float

	select	@WOOpt = left(S4Future11,1)
	from	WOSetup (nolock)
	where	Init = 'Y'

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
		ProdMgrID, PStdCostDate, PStdCst, PVOvhStdCst,
		QtyAlloc, QtyAvail, QtyCustOrd, QtyInTransit,
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
	select
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
		'', PStdCostDate,PStdCost, PVOvhStdCost,
		0, 0, 0, 0,
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
	from	Inventory (nolock)
	where	InvtID = @InvtID
	and	not exists (	select	InvtID, SiteID
				from	ItemSite
				where	InvtID = @InvtID
				and	SiteID = @SiteID)
if @@error != 0 return(@@error)

update ItemSite set
	QtyAllocBM = case when convert(dec(25,9),QtyAllocBM)-case @OldBucket when 1 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 1 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocBM)-case @OldBucket when 1 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 1 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocIN = case when convert(dec(25,9),QtyAllocIN)-case @OldBucket when 2 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 2 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocIN)-case @OldBucket when 2 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 2 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocPORet = case when convert(dec(25,9),QtyAllocPORet)-case @OldBucket when 3 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 3 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocPORet)-case @OldBucket when 3 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 3 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocSD = case when convert(dec(25,9),QtyAllocSD)-case @OldBucket when 4 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 4 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocSD)-case @OldBucket when 4 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 4 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAllocSO = case when convert(dec(25,9),QtyAllocSO)-case @OldBucket when 5 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 5 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAllocSO)-case @OldBucket when 5 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 5 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyShipNotInv = case when convert(dec(25,9),QtyShipNotInv)-case @OldBucket when 6 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 6 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyShipNotInv)-case @OldBucket when 6 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 6 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAlloc = case when convert(dec(25,9),QtyAlloc)-case @OldBucket when 7 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 7 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyAlloc)-case @OldBucket when 7 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 7 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyWORlsedDemand = case when convert(dec(25,9),QtyWORlsedDemand)-case @OldBucket when 8 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 8 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyWORlsedDemand)-case @OldBucket when 8 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 8 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyWOFirmDemand = case when convert(dec(25,9),QtyWOFirmDemand)-case @OldBucket when 9 then convert(dec(25,9),@OldAlloc) else 0 end < 0
				then case @NewBucket when 9 then convert(dec(25,9),@NewAlloc) else 0 end else
				convert(dec(25,9),QtyWOFirmDemand)-case @OldBucket when 9 then convert(dec(25,9),@OldAlloc) else 0 end+case @NewBucket when 9 then convert(dec(25,9),@NewAlloc) else 0 end
				end,
	QtyAvail = convert(dec(25,9),QtyAvail)-case when @NewBucket between 1 and 7 or @NewBucket = 8 and @WOOpt in ('F','R') or @NewBucket = 9 and @WOOpt = 'F' then convert(dec(25,9),@NewAlloc) else 0 end
			+ case @OldBucket when 1 then case when convert(dec(25,9),QtyAllocBM)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocBM)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 2 then case when convert(dec(25,9),QtyAllocIN)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocIN)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 3 then case when convert(dec(25,9),QtyAllocPORet)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocPORet)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 4 then case when convert(dec(25,9),QtyAllocSD)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocSD)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 5 then case when convert(dec(25,9),QtyAllocSO)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAllocSO)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 6 then case when convert(dec(25,9),QtyShipNotInv)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyShipNotInv)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case @OldBucket when 7 then case when convert(dec(25,9),QtyAlloc)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyAlloc)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case when @OldBucket = 8 and @WOOpt in ('F','R') then case when convert(dec(25,9),QtyWORlsedDemand)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),QtyWORlsedDemand)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end
			+ case when @OldBucket = 9 and @WOOpt = 'F' then case when convert(dec(25,9),S4Future03)-convert(dec(25,9),@OldAlloc) < 0
				then convert(dec(25,9),S4Future03)
				else convert(dec(25,9),@OldAlloc)
				end else 0 end,
	LUpd_Prog = @ProgId,
	LUpd_User = @UserId,
	LUpd_DateTime = getdate()
where InvtID = @InvtID and SiteID = @SiteID
if @@error != 0 return(@@error)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_UpdateAlloc_ItemSite] TO [MSDSL]
    AS [dbo];

