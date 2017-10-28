
CREATE  Procedure CF311p_cftFeedPlanHdr_FPId @parm1 varchar (4) as 
    Select * from cftFeedPlanHdr Where FeedPlanId Like @parm1
	Order by FeedPlanId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF311p_cftFeedPlanHdr_FPId] TO [MSDSL]
    AS [dbo];

