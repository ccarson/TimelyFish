CREATE  VIEW cfvFeedPlanDef
AS
-----------------------------------------------------------------------------------
-- CREATED BY: TJONES
-- CREATED ON: 8/2/05
-- LAST MODIFIED: 11/2/05 By TJones to add column for prior feed
-- USED IN: Feed Budget vs. Actual comparison report
-----------------------------------------------------------------------------------
SELECT pg.SiteContactID,pg.PigGroupID, pg.PGStatusID, pg.BarnNbr, RoomNbr=IsNull(pgr.RoomNbr,''),
	GenderTypeID = Isnull(pgr.PigGenderTypeID, pg.PigGenderTypeID),
	FeedPlanID = IsNull(pgr.FeedPlanId,pg.FeedPlanID), pg.PigProdPhaseID,
	StdOrIndBudgetFlag = CASE IsNull((SELECT DISTINCT FeedPlanID 
				FROM cftFeedPlanInd 
				WHERE PigGroupID = pg.PigGroupID 
				AND FeedPlanID = IsNull(pgr.FeedPlanID, pg.FeedPlanID) 
				AND RoomNbr = IsNull(pgr.RoomNbr,'')),'') 
				WHEN '' THEN 'STD' ELSE 'IND' END,
	PriorFeedQty = IsNull(pgr.PriorFeedQty, pg.PriorFeedQty)
	FROM cftPigGroup pg
	LEFT JOIN cftPigGroupRoom pgr ON pg.PigGroupID = pgr.PigGroupID
	WHERE pg.PGStatusID Not In('P')
