Create Procedure CF300p_cftFeedPlanDet_FPW @parm1 varchar (4), @parm2 float as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1 and @parm2 >= WgtLo and @parm2 < WgtHi

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedPlanDet_FPW] TO [MSDSL]
    AS [dbo];

