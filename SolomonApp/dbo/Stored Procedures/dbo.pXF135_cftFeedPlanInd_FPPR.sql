/****** Object:  Stored Procedure dbo.pXF135_cftFeedPlanInd_FPPR    Script Date: 8/22/2005 7:09:30 AM ******/
CREATE   Procedure pXF135_cftFeedPlanInd_FPPR @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10) as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 
	and (RoomNbr = @parm3 or RoomNbr = '') Order by FeedPlanId, PigGroupId, RoomNbr, Stage


