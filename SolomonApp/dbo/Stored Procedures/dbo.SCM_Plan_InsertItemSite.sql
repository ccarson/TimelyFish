 CREATE PROCEDURE SCM_Plan_InsertItemSite
	@ComputerName		VarChar(21),
	@CpnyID			Varchar(10),
	@Crtd_Prog		Varchar(8),
	@Crtd_User		Varchar(10)
AS
	SET NOCOUNT ON

	/*
	This procedure will determine if a record already exists matching
	the primary key.  If a record does not exist matching the primary key,
	a record will be inserted.
	*/
	INSERT INTO ItemSite
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
	SELECT 	I.ABCCode, I.AutoPODropShip,I.AutoPOPolicy,
		I.BMIDirStdCost, I.BMIFOvhStdCost, I.BMILastCost,I.BMIPDirStdCost,
		I.BMIPFOvhStdCost, I.BMIPStdCost,
		I.BMIPVOvhStdCost, I.BMIStdCost, I.BMIVOvhStdCost, I.Buyer,
		I.COGSAcct, I.COGSSub,
		@CpnyID, @Crtd_Prog, @Crtd_User,
		I.CountStatus, I.CyCleID,
		ISNULL(DSB.DfltPickBin,''),
		I.DfltPOUnit,
		ISNULL(DSB.DfltPutAwayBin,''),
		ISNULL(S.DfltRepairBin,''),
		I.DfltSOUnit,
		ISNULL(S.DfltVendorBin,''),
		I.DirStdCost, I.EOQ, I.FovhStdCost,
		INU.InvtID,
		I.InvtAcct, I.InvtSub,
		--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
		--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
		--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
		I.LeadTime, Convert(SmallDateTime, GetDate()),
		@Crtd_Prog, @Crtd_User,
		I.MaxOnHand, I.MfgClassID, I.MfgLeadTime, I.MoveClass,
		I.PdirStdCost, I.PFOvhStdCost, I.Supplr1, I.ProdMgrID, I.PStdCostDate,
		I.PStdCost, I.PVOvhStdCost,
		I.ReordPt,I.ReordPtCalc,I.ReordQty, I.ReordQtyCalc, I.ReplMthd, I.SafetyStk,
		I.SafetyStkCalc,
		I.DfltSalesAcct, I.DfltSalesSub, I.Supplr2, I.Selected,
		I.DfltShpnotInvAcct, I.DfltShpnotInvSub, I.StdCost,
		I.StdCostDate,
		INU.SiteID,
		I.S4Future12, I.StkItem, 	-- S4Future12 - MfgClassID
		I.Turns, I.UsageRate, I.VOvhStdCost, I.YTDUsage,
		I.IRRcycDays, I.IRMinOnHand, I.IRLinePtQty
	FROM	Inventory I
		JOIN 	INUpdateQty_Wrk INU (NOLOCK)
	  ON 	INU.InvtID = I.InvtID

	LEFT JOIN Site S (NOLOCK)
	  ON 	S.SiteID = INU.SiteID
	  AND	S.CpnyID = @CpnyID

	LEFT JOIN vp_DfltSiteBins DSB (NOLOCK)
	  ON 	DSB.InvtID = INU.InvtID
	  AND	DSB.CpnyID = @CpnyID

	WHERE	NOT EXISTS
			(SELECT * FROM ItemSite ItS
			WHERE 	ItS.InvtID = INU.InvtID
			AND 	ItS.SiteID = INU.SiteID)
	  AND	INU.ComputerName + '' LIKE @ComputerName


