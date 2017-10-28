Create Procedure CF303p_cftFeedPlanDet_FPW @parm1 varchar (4), @parm2 float as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1 and @parm2 Between WgtLo and WgtHi

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftFeedPlanDet_FPW] TO [MSDSL]
    AS [dbo];

