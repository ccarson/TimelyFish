
CREATE  Procedure CF311p_cftFeedPlanDet_FPId_Stage @parm1 varchar (4), @parm2beg smallint, @parm2end smallint as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1 and Stage Between @parm2beg and @parm2end
	Order by FeedPlanId, Stage


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF311p_cftFeedPlanDet_FPId_Stage] TO [MSDSL]
    AS [dbo];

