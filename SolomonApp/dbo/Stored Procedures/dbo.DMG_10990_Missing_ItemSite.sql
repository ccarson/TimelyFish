 Create	Proc DMG_10990_Missing_ItemSite
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will populate the ItemSite comparison table with any records that are missing from
	the comparison table.  The Master Timestamp field will alway be defaulted to a binary zero for all
	inserted records.  This will cause the Master Timestamp not to match with the ItemSite table insuring
	that the Inventory Item will be validated and rebuilt if that option is selected.
*/
	Set	NoCount On

	Declare	@BMIEnabled	SmallInt
	Select	@BMIEnabled = BMIEnabled
		From	INSetup

/*	This section of code will create any missing ItemSite records where INTran
	Records exist.	*/

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

		Select 	max(I.ABCCode), max(I.AutoPODropShip), max(I.AutoPOPolicy),
			max(I.BMIDirStdCost), max(I.BMIFOvhStdCost), max(I.BMILastCost), max(I.BMIPDirStdCost), max(I.BMIPFOvhStdCost), max(I.BMIPStdCost),
			max(I.BMIPVOvhStdCost), max(I.BMIStdCost), max(I.BMIVOvhStdCost), max(I.Buyer),
			max(I.COGSAcct), max(I.COGSSub), max(t.CpnyID), '10990', 'SYSADMIN',max(I.CountStatus),max(I.CycleID),
			max(coalesce(v.DfltPickBin,'')), max(I.DfltPOUnit), max(coalesce(v.DfltPutAwayBin,'')), max(coalesce(s.DfltRepairBin,'')), max(I.DfltSOUnit), max(coalesce(s.DfltVendorBin,'')),
			max(I.DirStdCost), max(I.EOQ), max(I.FOvhStdCost),t.InvtID, max(I.InvtAcct), max(I.InvtSub),
			--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
			--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
			--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
			max(I.LeadTime), Convert(SmallDateTime, GetDate()), '10990',
			'SYSADMIN',  max(I.MaxOnHand), max(I.MfgClassID), max(I.MfgLeadTime), max(I.MoveClass),
			max(I.PDirStdCost), max(I.PFOvhStdCost), max(I.Supplr1), max(I.ProdMgrID), max(I.PStdCostDate), max(I.PStdCost), max(I.PVOvhStdCost),
			max(I.ReordPt), max(I.ReordPtCalc), max(I.ReordQty), max(I.ReordQtyCalc), max(I.ReplMthd), max(I.SafetyStk), max(I.SafetyStkCalc),
			max(I.DfltSalesAcct), max(I.DfltSalesSub), max(I.Supplr2), max(I.Selected), max(I.DfltShpnotInvAcct), max(I.DfltShpnotInvSub), max(I.StdCost),
			max(I.StdCostDate), t.SiteID, max(I.S4Future12), max(I.StkItem), 	-- S4Future12 - MfgClassID
			max(I.Turns), max(I.UsageRate), max(I.VOvhStdCost), max(I.YTDUsage),
			max(I.IRRcycDays), max(I.IRMinOnHand), max(I.IRLinePtQty)
		from Intran t
		inner join Inventory I on I.InvtID = t.InvtID
		left join Site s on s.CpnyID = t.CpnyID and s.SiteID = t.SiteID
		left join vp_DfltSiteBins v on v.InvtID = t.InvtID and v.CpnyID = t.CpnyID
		left join ItemSite ys on ys.InvtID = t.InvtID and ys.SiteID = t.SiteID
		where ys.SiteID is null
			AND t.InvtID LIKE @InvtIDParm
		group by t.InvtID, t.SiteID

	Insert Into	IN10990_ItemSite
			(AvgCost, BMIAvgCost, BMIDirStdCst, BMIFOvhStdCst, BMILastCost,
			BMIStdCost, BMITotCost, BMIVOvhStdCst, Changed, CpnyID,
			Crtd_DateTime, Crtd_Prog, Crtd_User, DirStdCst, FOvhStdCst,
			InvtID, LastCost, LUpd_DateTime, LUpd_Prog, LUpd_User,
			MstStamp, MaxOnHand, QtyOnHand,
			S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
			S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
			S4Future11, S4Future12,
			SiteID, StdCost,
			StdCostDate, TotCost,
			User1, User2, User3, User4, User5, User6, User7, User8,
			VOvhStdCst)
		Select	ItemSite.AvgCost,
			BMIAvgCost = Case When @BMIEnabled = 1 Then ItemSite.BMIAvgCost Else 0 End,
			BMIDirStdCst = Case When @BMIEnabled = 1 Then ItemSite.BMIDirStdCst Else 0 End,
			BMIFOvhStdCst = Case When @BMIEnabled = 1 Then ItemSite.BMIFOvhStdCst Else 0 End,
			BMILastCost = Case When @BMIEnabled = 1 Then ItemSite.BMILastCost Else 0 End,
			BMIStdCost = Case When @BMIEnabled = 1 Then ItemSite.BMIStdCost Else 0 End,
			BMITotCost = Case When @BMIEnabled = 1 Then ItemSite.BMITotCost Else 0 End,
			BMIVOvhStdCst = Case When @BMIEnabled = 1 Then ItemSite.BMIVOvhStdCst Else 0 End,
			Changed = 0, ItemSite.CpnyID,
			ItemSite.Crtd_DateTime, ItemSite.Crtd_Prog, ItemSite.Crtd_User, ItemSite.DirStdCst, ItemSite.FOvhStdCst,
			ItemSite.InvtID, ItemSite.LastCost, ItemSite.LUpd_DateTime, ItemSite.LUpd_Prog, ItemSite.LUpd_User,
			MstStamp = Cast(0 As Binary(8)), ItemSite.MaxOnHand, ItemSite.QtyOnHand,
			ItemSite.S4Future01, ItemSite.S4Future02, ItemSite.S4Future03,
			ItemSite.S4Future04, ItemSite.S4Future05, ItemSite.S4Future06,
			ItemSite.S4Future07, ItemSite.S4Future08, ItemSite.S4Future09,
			ItemSite.S4Future10, ItemSite.S4Future11, ItemSite.S4Future12,
			ItemSite.SiteID, ItemSite.StdCost,
			ItemSite.StdCostDate, ItemSite.TotCost,
			ItemSite.User1, ItemSite.User2, ItemSite.User3, ItemSite.User4,
			ItemSite.User5, ItemSite.User6, ItemSite.User7, ItemSite.User8,
			ItemSite.VOvhStdCst
		From	ItemSite Left Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
		Where	IN10990_ItemSite.InvtID Is Null
			AND ItemSite.InvtID LIKE @InvtIDParm


