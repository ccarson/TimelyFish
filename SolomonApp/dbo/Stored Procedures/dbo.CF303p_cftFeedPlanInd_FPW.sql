Create Procedure CF303p_cftFeedPlanInd_FPW @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10), @parm4 float as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 and @parm4 Between WgtLo and WgtHi
	and (RoomNbr = @parm3 or RoomNbr = '')

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftFeedPlanInd_FPW] TO [MSDSL]
    AS [dbo];

