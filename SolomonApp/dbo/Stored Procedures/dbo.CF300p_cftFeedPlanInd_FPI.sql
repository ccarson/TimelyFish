Create Procedure CF300p_cftFeedPlanInd_FPI @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (30) as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 and InvtId = @parm4
	and (RoomNbr = @parm3 or RoomNbr = '')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedPlanInd_FPI] TO [MSDSL]
    AS [dbo];

