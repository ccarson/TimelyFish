CREATE Procedure pXF135_cftFeedPlanDet_FPNextS @parm1 varchar (4), @parm2 smallint as 
    Select * from cftFeedPlanDet Where FeedPlanId = @parm1 and Stage > @parm2
	Order by FeedPlanId, Stage

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cftFeedPlanDet_FPNextS] TO [MSDSL]
    AS [dbo];

