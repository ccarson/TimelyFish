
CREATE  Procedure CF310p_cftFeedPlanInd_FPId @parm1 varchar (4) as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF310p_cftFeedPlanInd_FPId] TO [MSDSL]
    AS [dbo];

