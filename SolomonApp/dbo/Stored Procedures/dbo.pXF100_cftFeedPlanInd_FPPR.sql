CREATE  Procedure pXF100_cftFeedPlanInd_FPPR @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10) as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 
	and (RoomNbr = @parm3 or RoomNbr = '') Order by FeedPlanId, PigGroupId, RoomNbr, Stage


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftFeedPlanInd_FPPR] TO [MSDSL]
    AS [dbo];

