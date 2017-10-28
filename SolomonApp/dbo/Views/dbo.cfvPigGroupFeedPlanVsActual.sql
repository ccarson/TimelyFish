
---------------------------------------------------------------------------------------
-- PURPOSE:Used for comparing feed budget to actual feed orders
-- CREATED BY: TJONES
-- CREATED ON: 11/2/05
-- USED BY: Brent/JoDee
---------------------------------------------------------------------------------------
CREATE  VIEW [dbo].[cfvPigGroupFeedPlanVsActual]
	AS
SELECT pg.SiteContactID,SiteName = c.ContactName,
	pg.PigGroupID, fpd.RoomNbr, pg.EstInventory, fpd.GenderTypeID,
	pg.PigProdPhaseID,pg.PGStatusID,
	FeedPlanType=fpd.StdOrIndBudgetFlag, 
	DateSwitchedToIndPlan=(Select IsNull(Min(Convert(varchar(10),Crtd_DateTime,101)),'N/A')
					FROM cftFeedPlanInd
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr),
	CalcCurWgt = IsNull(pm.CalcCurWgt,0),
        ActStartWgt = case when v.qty <> 0 then v.Twgt/v.qty else 0 end,
	AvgPriorFeed = 	case when pr.NumberOfOrders <> 0 then pr.PriorFeed/pr.NumberOfOrders else 0 end,
	StartQty = v.Qty, 
	PigSystem = ps.Description, 
	LastRationOrd = IsNull((Select TOP 1 InvtIDOrd 
					FROM cftFeedOrder
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr	
					AND Status <> 'X'
					ORDER BY StageOrd DESC, DateReq DESC ),'N/A'),

	fpd.PriorFeedQty, 
	BdgtLbsPerHead44 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '044%'),
	DelvLbsPerHead44 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '044%'), 
	BdgtLbsPerHead51 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '051%'),
	DelvLbsPerHead51 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '051%'), 
	BdgtLbsPerHead52 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '052%'),
	DelvLbsPerHead52 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '052%'), 
	BdgtLbsPerHead53 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '053%'),
	DelvLbsPerHead53 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '053%'), 
	BdgtLbsPerHead54 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '054%'),
	DelvLbsPerHead54 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '054%'), 
	BdgtLbsPerHead55 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '055%'),
	DelvLbsPerHead55 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '055%'), 
	BdgtLbsPerHead75 = (Select IsNull(Sum(LbsHead),0)
					FROM cfvFeedPlanDefDet 
					WHERE PigGroupID = fpd.PigGroupID 
					AND RoomNbr = fpd.RoomNbr 
					AND InvtID Like '075%'),
	DelvLbsPerHead75 = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND InvtID Like '075%'),
	DelvLbsPerHeadOther = (Select IsNull(Sum(case when PGQty <> 0 then Qty/PGQty else 0 end),0)
					FROM cfvFeedOrderWithStatusCalcs
					WHERE PigGroupID = fpd.PigGroupID
					AND RoomNbr = fpd.RoomNbr
					AND Left(InvtID,3) Not In('044','051','052','053','054','055','075'))
	From cfvFeedPlanDef fpd
	JOIN cftPigGroup pg ON fpd.PigGroupID = pg.PigGroupID
	JOIN cftContact c ON pg.SiteContactID = c.ContactID
	LEFT JOIN cftPigPreMkt pm ON fpd.PigGroupID = pm.PigGroupID
	JOIN cfv_GroupStart v ON pg.PigGroupID = v.PigGroupID
	JOIN cftPigSystem ps ON pg.PigSystemID = ps.PigSystemID
	JOIN cfvFeedOrderPriorFeed pr ON pg.PigGroupID=pr.PigGroupID AND fpd.RoomNbr=pr.RoomNbr
	WHERE pg.PigProdPhaseID In('FIN')
