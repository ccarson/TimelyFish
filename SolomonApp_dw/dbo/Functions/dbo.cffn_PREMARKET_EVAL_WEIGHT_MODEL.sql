

-- =============================================
-- Author:		Matt Brandt
-- Create date: 02/09/2010
-- Description:	This function returns the Feed Efficiency for a flow given the FlowID, Stage (Finishing or WTF) and Pig Gender.
-- =============================================
CREATE FUNCTION [dbo].[cffn_PREMARKET_EVAL_WEIGHT_MODEL] 
(@BaseFeedEfficiency Float,@EstimatedStartWeight Float, @FeedPoundsEatenPerPig Float, @SiteEfficiencyFactor Float)
RETURNS Float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @EstimatedWeight Float

-----------------------------------------------------------------------------
--Pre-Market Evaluation Weight Model
-----------------------------------------------------------------------------

Declare @AdjustmentFactor Float
Declare @WeightCounter Int

Set @AdjustmentFactor = .005

Set @WeightCounter = Cast(@EstimatedStartWeight As Int)

Declare @FeedEfficiency Table
(EstimatedWeight Float, CalculatedFeedEfficiency Float)

While @WeightCounter < 351
	Begin
	Insert Into @FeedEfficiency
	Select @WeightCounter As EstimatedWeight, (@BaseFeedEfficiency
									-((270-@WeightCounter)*@AdjustmentFactor)
									-((50-@EstimatedStartWeight)*@AdjustmentFactor))*@SiteEfficiencyFactor
	Set @WeightCounter = @WeightCounter+1
	End

-----------------
--Results Testing
-----------------
--Select EstimatedWeight, CalculatedFeedEfficiency
--, @EstimatedStartWeight+@FeedPoundsEatenPerPig/CalculatedFeedEfficiency As ProjectedWeight
--, ABS(EstimatedWeight-(@EstimatedStartWeight+@FeedPoundsEatenPerPig/CalculatedFeedEfficiency)) As Delta
--From @FeedEfficiency
--Order By Delta

Set @EstimatedWeight = (Select Top 1 EstimatedWeight From @FeedEfficiency
	Order By ABS(EstimatedWeight-(@EstimatedStartWeight+@FeedPoundsEatenPerPig/CalculatedFeedEfficiency))
	)

Return @EstimatedWeight

End

