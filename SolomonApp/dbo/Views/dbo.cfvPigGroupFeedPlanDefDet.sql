

CREATE VIEW [dbo].[cfvPigGroupFeedPlanDefDet]
	AS
	---------------------------------------------------------------------------------------
	-- PURPOSE: show a simple view of what a finishing or wean-to-finishing groups feed  
	-- budget is. Also adds the calculated cumulative pounds column
	-- CREATED BY: TJONES
	-- CREATED ON: 8/4/05
	---------------------------------------------------------------------------------------
	-- SELECT Group Feed Plan Detail for groups on an individual feed plan
	/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2016-01-09  Doran Dahle Changed to include HIN.

===============================================================================
*/
	
	SELECT v.*, InvtID, LbsHead, 
	CummLbsHead = (Select Sum(LbsHead) FROM cftFeedPlanInd WHERE FeedPlanID = fp.FeedPlanID 
					AND PigGroupID = v.PigGroupID
					AND RoomNbr = v.RoomNbr
					AND Stage <= fp.Stage),
	Stage, Tolerance, WgtLo, WgtHi  
	FROM cfvPigGroupFeedPlanDef v
	JOIN cftFeedPlanInd fp ON v.FeedPlanID = fp.FeedPlanID 
		AND v.PigGroupID = fp.PigGroupID
		AND v.RoomNbr = fp.RoomNbr
	WHERE v.PGStatusID = 'A'
	AND v.StdOrIndBudgetFlag = 'IND'
	AND v.PigProdPhaseID In('FIN','WTF','HIN')
	
	UNION

	-- SELECT Feed Plan Detail for Groups using standard feed plans
	SELECT v.*, InvtID, LbsHead, 
	CummLbsHead = (Select Sum(LbsHead) FROM cftFeedPlanDet WHERE FeedPlanID = fp.FeedPlanID AND Stage <= fp.Stage),
	Stage, Tolerance, WgtLo, WgtHi
	FROM cfvPigGroupFeedPlanDef v
	JOIN cftFeedPlanDet fp ON v.FeedPlanID = fp.FeedPlanID 
	WHERE v.PGStatusID = 'A'
	AND v.StdOrIndBudgetFlag = 'STD'
	AND v.PigProdPhaseID In('FIN','WTF','HIN')


