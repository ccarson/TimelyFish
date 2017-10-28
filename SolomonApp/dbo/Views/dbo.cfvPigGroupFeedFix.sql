CREATE VIEW cfvPigGroupFeedFix
AS
SELECT v.*, CummActPerPigFeedQty = Round(CumulativeFeedQty/PigQty,2),
	CummBudgPerPigFeedQty = (SELECT CummLbsHead FROM cfvPigGroupFeedPlanDefDet 
				WHERE PigGroupID = v.PigGroupID AND RoomNbr = v.RoomNbr AND Stage = v.MaxStage), 
	MaxStagePerPigQty = Round(MaxStageQty/PigQty,2),
	SuggestedRation = (SELECT TOP 1 InvtID From cfvPigGroupFeedPlanDefDet  WHERE PigGroupID = v.PigGroupID AND Stage >=5
				AND RoomNbr = v.RoomNbr AND CummLbsHead > Round(CumulativeFeedQty/PigQty,2) ORDER BY Stage)
	FROM cfvGroupFeedCalcDet v
	WHERE PigGroupID Not In(SELECT DISTINCT PigGroupID FROM cfvPigGroupFeedPlanDefDet WHERE InvtID In('075M','055M-TY100','075M-TY100') AND StdOrIndBudgetFlag = 'IND')
	AND PigGroupID Not In(SELECT DISTINCT PigGroupID FROM cftFeedOrder WHERE InvtIDOrd = '055M')
