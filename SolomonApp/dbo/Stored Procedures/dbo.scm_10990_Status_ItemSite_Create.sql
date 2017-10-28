 CREATE PROC scm_10990_Status_ItemSite_Create @InvtID varchar(30), @siteID varchar(10), @user varchar(10) as

DECLARE @Today smalldatetime

SELECT @Today = GETDATE()

if @invtid = '%' and @siteid = '%'

	Insert Into	ItemSite
			(ABCCode, AutoPODropShip,AutoPOPolicy,
			BMIDirStdCst, BMIFOvhStdCst, BMILastCost,BMIPDirStdCst, BMIPFOvhStdCst,BMIPStdCst,
			BMIPVOvhStdCst, BMIStdCost, BMIVOvhStdCst, Buyer,
			COGSAcct, COGSSub, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,CountStatus,CyCleID,
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
			max(I.COGSAcct), max(I.COGSSub), max(t.CpnyID), @Today, '10990', @user,max(I.CountStatus),max(I.CycleID),
			max(coalesce(v.DfltPickBin,'')), max(I.DfltPOUnit), max(coalesce(v.DfltPutAwayBin,'')), max(coalesce(s.DfltRepairBin,'')), max(I.DfltSOUnit), max(coalesce(s.DfltVendorBin,'')),
			max(I.DirStdCost), max(I.EOQ), max(I.FOvhStdCost),t.InvtID, max(I.InvtAcct), max(I.InvtSub),
			--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
			--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
			--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
			max(I.LeadTime), @Today, '09901',
			@user,  max(I.MaxOnHand), max(I.MfgClassID), max(I.MfgLeadTime), max(I.MoveClass),
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
		group by t.InvtID, t.SiteID

else

	Insert Into	ItemSite
			(ABCCode, AutoPODropShip,AutoPOPolicy,
			BMIDirStdCst, BMIFOvhStdCst, BMILastCost,BMIPDirStdCst, BMIPFOvhStdCst,BMIPStdCst,
			BMIPVOvhStdCst, BMIStdCost, BMIVOvhStdCst, Buyer,
			COGSAcct, COGSSub, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,CountStatus,CyCleID,
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
			max(I.COGSAcct), max(I.COGSSub), max(t.CpnyID), @Today, '10990', @user,max(I.CountStatus),max(I.CycleID),
			max(coalesce(v.DfltPickBin,'')), max(I.DfltPOUnit), max(coalesce(v.DfltPutAwayBin,'')), max(coalesce(s.DfltRepairBin,'')), max(I.DfltSOUnit), max(coalesce(s.DfltVendorBin,'')),
			max(I.DirStdCost), max(I.EOQ), max(I.FOvhStdCost),t.InvtID, max(I.InvtAcct), max(I.InvtSub),
			--* IRDaysSupply,IRDemandID,IRFutureDate,IRFuturePolicy,IRLeadTimeID,IRMinOnHand,IRModelInvtID,
			--* IRRCycDays,IRSeasonEndDay,IRSeasonEndMon,IRSeasonStrtDay,IRSeasonStrtMon,IRServiceLevel,
			--* IRSftyStkDays,IRSftyStkPct,IRSftyStkPolicy,IRSourceCode,IRTargetOrdMethod,IRTargetOrdReq,IRTransferSiteID,
			max(I.LeadTime), @Today, '09901',
			@user,  max(I.MaxOnHand), max(I.MfgClassID), max(I.MfgLeadTime), max(I.MoveClass),
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
		where t.InvtID like @InvtID and t.SiteID like @SiteID and ys.SiteID is null
		group by t.InvtID, t.SiteID


