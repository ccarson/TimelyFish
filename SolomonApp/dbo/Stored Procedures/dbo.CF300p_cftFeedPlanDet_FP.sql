Create Procedure CF300p_cftFeedPlanDet_FP @parm1 varchar (4) as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1
	Order by FeedPlanId, Stage

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedPlanDet_FP] TO [MSDSL]
    AS [dbo];

