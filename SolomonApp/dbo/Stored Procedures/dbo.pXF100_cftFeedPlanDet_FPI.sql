Create Procedure pXF100_cftFeedPlanDet_FPI @parm1 varchar (4), @parm2 varchar (30) as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1 and InvtId = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFeedPlanDet_FPI] TO [MSDSL]
    AS [dbo];

