 create proc ADG_Invt_NewItem
	@InvtID		char (30),
	@SiteID		char (10),
	@WhseLoc	char (10),	-- can be empty
	@LotSerNbr	char (25),	-- can be empty
        @ProgID 	varchar (8),
        @UserID 	varchar (10),
        @ErrorCode	smallint	output
as
	set nocount on

	declare	@CpnyID	varchar(10)

	select	@CpnyID = CpnyID
	from	Site
	where	SiteID = @SiteID

	select @CpnyID = coalesce(@CpnyID, '')

    	select	@ErrorCode = 0

	-- ItemSite

	-- LeadTime = 999 to make it obvious that it needs to be fixed

	-- If there isn't an ItemSite record already for this item/site combination
	if (select count(*) from ItemSite where InvtID = @InvtID and SiteID = @SiteID) = 0
	begin
		insert ItemSite
		(
			ABCCode, AllocQty, AvgCost, BMIAvgCost,
			BMIDirStdCst, BMIFovhStdCst, BMILastCost, BMIPDirStdCst,
			BMIPFOvhStdCst, BMIPStdCst, BMIPVOvhStdCst, BMIStdCost,
			BMITotCost, BMIVOvhStdCst, Buyer, COGSAcct,
			COGSSub, CountStatus, CpnyId, Crtd_DateTime,
			Crtd_Prog, Crtd_User, CycleId, DfltPOUnit,
			DfltSOUnit, DirStdCst, EOQ, FOvhStdCst,
			InvtAcct, InvtId, InvtSub, LastBookQty,
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
			COGSSub, 'A', @CpnyID, GetDate(),
			@ProgID, @UserID, CycleID, DfltPOUnit,
			DfltSOUnit, DirStdCost, 0, FOvhStdCost,
			InvtAcct, @InvtId, InvtSub, 0,
			LastCost, '', '', 0,
			0, 0, 0, 0,
			'', 999, GetDate(), @ProgID,
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
			DfltShpNotInvAcct, DfltShpNotInvSub, @SiteId, StdCost,
			StdCostDate, StkItem, 0, 0,
			UsageRate, '', '', 0,
			0, '', '', '',
			'', VOvhStdCost, 0
		from  Inventory
        	where InvtId = @InvtID
	end

	if (@@error = 0)
		print 'ItemSite complete'
	else
	begin
		print 'ItemSite error'
		select @ErrorCode = 1
		goto FINISH
	end

	-- LocTable
	if (rtrim(@WhseLoc) > '')
	begin
		-- If there isn't a LocTable record already for this site/bin combination
		if (select count(*) from LocTable where SiteID = @SiteID and WhseLoc = @WhseLoc) = 0
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
	  		left join ItemSite  i
	  		on	i.InvtID = @InvtID
	  		and	i.SiteID = @SiteID
			where	s.SiteID = @SiteID
		end

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
	if (rtrim(@WhseLoc) > '')
	begin
		-- If there isn't a Location record already for this item/site/bin combination
		if (select count(*) from Location where InvtID = @InvtID and SiteID = @SiteID and WhseLoc = @WhseLoc) = 0
		begin
			insert	Location
			(
				CountStatus, Crtd_DateTime, Crtd_Prog, Crtd_User,
				InvtId, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId,
				PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv,
				QtyAlloc, QtyAllocProjIN, QtyOnHand, QtyShipNotInv, 
				QtyWORlsedDemand, S4Future01, S4Future02, S4Future03,
				S4Future04, S4Future05, S4Future06, S4Future07,
				S4Future08, S4Future09, S4Future10, S4Future11,
				S4Future12, Selected, SiteId, User1, User2, User3,
				User4, User5, User6, User7, User8, WhseLoc
			)
			select distinct
				'A', GetDate(), @ProgID, @UserID, 
				@InvtId, GetDate(), @ProgID, @UserID, 0,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, 
				0, '', '', 0, 0, 0,
				0, '', '', 0, 0, '', '', 0,
				@SiteId, '', '', 0, 0, '', '', '',
				'', @WhseLoc
			from	Inventory
			where	InvtID = @InvtID
		end

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

	-- Source is defaulted to 'OM' for Order Management

	-- Status is defaulted to 'H' to put the lot/serial number on
	-- hold until it's costed (the status will be changed to 'A'
	-- (Available) at that time.

	if (rtrim(@LotSerNbr) > '') and (rtrim(@WhseLoc) > '')
	begin
		-- If there isn't a LotSerMst record already for this item/lotsernbr/site/bin combination
		if (select count(*) from LotSerMst where InvtID = @InvtID and LotSerNbr = @LotSerNbr and SiteID = @SiteID and WhseLoc = @WhseLoc) = 0
		begin
			insert	LotSerMst
			(
				Cost, Crtd_DateTime, Crtd_Prog, Crtd_User,
				ExpDate, InvtID, LIFODate, LotSerNbr,
				LUpd_DateTime, LUpd_Prog, LUpd_User,
				MfgrLotSerNbr, NoteID, OrigQty, 
				PrjINQtyAlloc, PrjINQtyAllocIN, PrjINQtyAllocPORet, PrjINQtyAllocSO, PrjINQtyShipNotInv, QtyAlloc,
				QtyAllocProjIN, QtyOnHand, QtyShipNotInv, QtyWORlsedDemand,
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
				0, GetDate(), @ProgID, @UserID, 
				'', @InvtID, '', @LotSerNbr, 
				GetDate(), @ProgID, @UserID,
				'', 0, 0, 
				0, 0, 0, 0, 0, 0,
				0, 0, 0, 0,
				'', '',  '', 0, 0, 0, 0,
				'', '', 0, 0,  '', '', '', @SiteID,  'OM', '',
				'H', '', '', '', 0, 0, '', '', '', '', '',
				@WhseLoc
			from	Inventory
        		where	InvtId = @InvtID
		end

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

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


