

-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/08/2010
-- Description:	This function returns the Feed Efficiency for a flow given the FlowID, Stage (Finishing or WTF) and Pig Gender.
-- =============================================
CREATE FUNCTION [dbo].[cffn_FEED_EFFICIENCY_BY_FLOW] 
(@PigFlowID Int, @Phase Char(3), @PigGenderTypeID Char(1), @CurrentDate Datetime)
RETURNS Float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FeedEfficiency Float


Declare @FeedData Table
(TaskID Char(10), PigFlowID Int, Phase Char(3), PigGenderTypeID Char(1), AdjFeedToGain Float)


Insert Into @FeedData

Select pgr.TaskID, pgr.PigFlowID, pgr.Phase, pgr.PigGenderTypeID
, pgr.AdjFeedToGain 
	--If the PigGroup received Paylean increase AdjFeedToGain by .05
	+ Case When IsNull((Select Sum(f.QtyDel)  
						From [$(SolomonApp)].dbo.cftFeedOrder f 
						Where f.InvtIdDel LIKE '075M%' 
						And f.PigGroupID = RTrim(Substring(pgr.TaskID,3,10))),0) > 0
		Then .05 Else 0 End As AdjFeedToGain
From  dbo.cft_PIG_GROUP_ROLLUP pgr
Where pgr.Phase In('WTF','FIN') And pgr.ActCloseDate >= DateAdd(dd,-29,@CurrentDate)


Declare @FeedToGain Table 
(PigFlowID Int, Phase Char(3), PigGenderTypeID Char(1), AdjFeedToGain Float)

--Mixed
Insert Into @FeedToGain
Select PigFlowID, Phase, 'M'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)
From @FeedData
Group By PigFlowID, Phase

--Barrows
Insert Into @FeedToGain
Select PigFlowID, Phase, 'B'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)+.05
From @FeedData
Group By PigFlowID, Phase

--Gilts
Insert Into @FeedToGain
Select PigFlowID, Phase, 'G'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)-.05
From @FeedData
Group By PigFlowID, Phase

--System Wide
Insert Into @FeedToGain
Select 0, Phase, 'M'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)
From @FeedData
Group By Phase

Insert Into @FeedToGain
Select 0, Phase, 'B'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)+.05
From @FeedData
Group By Phase

Insert Into @FeedToGain
Select 0, Phase, 'G'
, Avg(Case When PigGenderTypeID = 'B' Then AdjFeedToGain-.05
			When PigGenderTypeID = 'G' Then AdjFeedToGain+.05
			Else AdjFeedToGain End)-.05
From @FeedData
Group By Phase

Select @FeedEfficiency = 
	IsNull(
	--If we have data for this criteria use it.
	(Select AdjFeedToGain From @FeedToGain Where @PigFlowID = PigFlowID And @Phase = Phase And @PigGenderTypeID = PigGenderTypeID)
	,
	--If we don't, use the system wide data instead.
	(Select AdjFeedToGain From @FeedToGain Where 0 = PigFlowID And @Phase = Phase And @PigGenderTypeID = PigGenderTypeID)
	)
From @FeedToGain

			
Return @FeedEfficiency

End

