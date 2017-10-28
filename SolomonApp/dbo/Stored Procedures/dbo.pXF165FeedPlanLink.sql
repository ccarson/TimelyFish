


CREATE Procedure [dbo].[pXF165FeedPlanLink] 
@FeedPlanID varchar(4),
@FlowID varchar(3),
@MillID varchar(6),
@GenderID varchar(6),
@SystemID varchar(2)
as

Select *
from [dbo].[cftFeedPlanLink]
Where FeedPlanID like Case When lTrim(rTrim(@FeedPlanID)) = '' Then '%' Else @FeedPlanID End
AND FlowID Like Case When lTrim(rTrim(@FlowID)) = '' Then '%' Else @FlowID End
AND MillID Like Case When lTrim(rTrim(@MillID)) = '' Then '%' Else @MillID End 
AND GenderID like @GenderID
AND SystemID like @SystemID
Order by FeedPlanID
	
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165FeedPlanLink] TO [MSDSL]
    AS [dbo];

