 Create Procedure DMG_Insert_ItemSite
	@InvtID			Varchar(30),
	@SiteID			Varchar(10),
	@CpnyID			Varchar(10),
	@Crtd_Prog		Varchar(8),
	@Crtd_User		Varchar(10)
As
	Set NoCount On
	/*
	All of the parameters being passed to this procedure are parts of the
	table's primary key except @Crtd_Prog and @Crtd_User.  This procedure will
	use those parameters to determine if a record already exists matching
	the primary key.  If a record does not exist matching the primary key,
	a record will be inserted.

	Returns:	@True = 1	The procedure executed properly.
			@False = 0	An error occurred.
	*/
	Declare	@True		Bit,
		@False		Bit
	Select	@True 		= 1,
		@False 		= 0

	Declare	@SQLErrNbr	SmallInt
	Select	@SQLErrNbr	= 0

	Declare	@RepairBin	VarChar(10),
		@VendorBin	VarChar(10),
		@PickBin	VarChar(10),
		@PutAwayBin	VarChar(10)

	Select	@RepairBin = '',
		@VendorBin = '',
		@PickBin = '',
		@PutAwayBin = ''
	/* Defect 230717 - blank cpnyid passed in on 2 step transfer */
	If (SELECT @cpnyid) = ''
	Begin
	(
		Select @cpnyid =
			(Select CpnyID
				from Site
				where SiteID = @siteID)
		)
	End

	If Not Exists (	Select	*
				From	ItemSite
				Where	InvtID = @InvtID
					And SiteID = @SiteID)
	Begin
		Select	@RepairBin = DfltRepairBin,
			@VendorBin = DfltVendorBin
			From	Site (NoLock)
			Where	CpnyID = @CpnyID
				And SiteID = @SiteID

		Select	@PickBin = DfltPickBin,
			@PutAwayBin = DfltPutAwayBin
			From	vp_DfltSiteBins (NoLock)
			Where	InvtID = @InvtID
				And CpnyID = @CpnyID

		Insert Into	ItemSite
				(ABCCode, AutoPODropShip,AutoPOPolicy,
				BMIDirStdCst, BMIFOvhStdCst, BMILastCost,BMIPDirStdCst, BMIPFOvhStdCst,BMIPStdCst,
				BMIPVOvhStdCst, BMIStdCost, BMIVOvhStdCst, Buyer,
				COGSAcct, COGSSub, CpnyID, Crtd_Prog, Crtd_User,CountStatus,CyCleID,
				DfltPickBin,DfltPOUnit,DfltPutAwayBin,DfltRepairBin,DfltSOUnit,DfltVendorBin,
				DirStdCst, EOQ, FovhStdCst, InvtID, InvtAcct, InvtSub,
				--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
				--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
				--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
				LeadTime, LUpd_DateTime, LUpd_Prog,
				LUpd_User, MaxOnHand,MfgClassID, MfgLeadTime, MoveClass,
				PdirStdCst, PFOvhStdCst,PrimVendID,ProdMgrID,PStdCostDate, PStdCst, PVOvhStdCst,
				ReordPt,ReordPtCalc,ReordQty,ReordQtyCalc,ReplMthd,SafetyStk,SafetyStkCalc,
				SalesAcct,SalesSub,SecondVendID,Selected,ShipNotInvAcct,ShipNotInvSub,StdCost,
				StdCostDate, SiteID, S4Future12, StkItem, 	-- S4Future12 - MfgClassID
				Turns,UsageRate,VOvhStdCst ,YTDUsage,
				IRRcycDays, IRMinOnHand, IRLinePt)

			Select 	ABCCode, AutoPODropShip,AutoPOPolicy,
				BMIDirStdCost, BMIFOvhStdCost, BMILastCost,BMIPDirStdCost, BMIPFOvhStdCost,BMIPStdCost,
				BMIPVOvhStdCost, BMIStdCost, BMIVOvhStdCost, Buyer,
				COGSAcct, COGSSub, @CpnyID, @Crtd_Prog, @Crtd_User,CountStatus,CyCleID,
				@PickBin,DfltPOUnit,@PutAwayBin,@RepairBin,DfltSOUnit,@VendorBin,
				DirStdCost, EOQ, FovhStdCost,@InvtID, InvtAcct, InvtSub,
				--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
				--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
				--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
				LeadTime, Convert(SmallDateTime, GetDate()), @Crtd_Prog,
				@Crtd_User,  MaxOnHand,MfgClassID, MfgLeadTime, MoveClass,
				PdirStdCost,PFOvhStdCost,Supplr1,ProdMgrID,PStdCostDate, PStdCost, PVOvhStdCost,
				ReordPt,ReordPtCalc,ReordQty,ReordQtyCalc,ReplMthd,SafetyStk,SafetyStkCalc,
				DfltSalesAcct, DfltSalesSub,Supplr2,Selected,DfltShpnotInvAcct, DfltShpnotInvSub,StdCost,
				StdCostDate, @SiteID,S4Future12, StkItem, 	-- S4Future12 - MfgClassID
				Turns,UsageRate,VOvhStdCost ,YTDUsage,
				IRRcycDays, IRMinOnHand, IRLinePtQty
			From	Inventory
			Where   InvtID = @InvtID

		Select @SQLErrNbr = @@Error
		If @SQLErrNbr <> 0
		Begin
			Insert 	Into IN10400_RETURN
					(S4Future01, SQLErrorNbr)
				Values
					('DMG_Insert_ItemSite', @SQLErrNbr)
			Goto Abort
		End
	End

Goto Finish

Abort:
	Return @False

Finish:
	Return @True


