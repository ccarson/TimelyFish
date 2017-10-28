

CREATE  VIEW [dbo].[cfvFeedPlanDefDet]
	AS
---------------------------------------------------------------------------------------
-- PURPOSE: show a simple view of what a group's feed  
-- budget is. Also adds the calculated cumulative pounds column
-- CREATED BY: TJONES
-- CREATED ON: 8/4/05
---------------------------------------------------------------------------------------
	/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2016-01-09  Doran Dahle Changed to include HIN.

===============================================================================
*/
SELECT v.*, InvtID, LbsHead, 
	CummLbsHead = fp.AccumLbsHead,
	--(Select Sum(LbsHead) FROM cftFeedPlanInd WHERE FeedPlanID = fp.FeedPlanID 
	--				AND PigGroupID = v.PigGroupID
	--				AND RoomNbr = v.RoomNbr
	--				AND Stage <= fp.Stage),
	Stage, Tolerance, WgtLo, WgtHi, fp.AdvToNextStageLbs, fp.tstamp
	FROM cfvFeedPlanDef v
	JOIN cftFeedPlanInd fp ON v.FeedPlanID = fp.FeedPlanID 
		AND v.PigGroupID = fp.PigGroupID
		AND v.RoomNbr = fp.RoomNbr 
	WHERE --v.PGStatusID In('A','F') AND -- Remove filter 11/2/05 - TJones need to use view for closed groups too
	v.StdOrIndBudgetFlag = 'IND'
	AND v.PigProdPhaseID In('NUR','FIN','WTF','TEF','HIN')
	
	UNION

	-- SELECT Feed Plan Detail for Groups using standard feed plans
	SELECT v.*, InvtID, LbsHead, 
	CummLbsHead = AccumLbsHead,
	--(Select Sum(LbsHead) FROM cftFeedPlanDet WHERE FeedPlanID = fp.FeedPlanID AND Stage <= fp.Stage),
	Stage, Tolerance, WgtLo, WgtHi, fp.AdvToNextStageLbs, fp.tstamp
	FROM cfvFeedPlanDef v
	JOIN cftFeedPlanDet fp ON v.FeedPlanID = fp.FeedPlanID 
	WHERE --v.PGStatusID In('A','F')
	v.StdOrIndBudgetFlag = 'STD'
	AND v.PigProdPhaseID In('NUR','FIN','WTF','TEF','HIN')


