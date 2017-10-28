
CREATE  Procedure CF311p_cftFeedPlanInd_FPId_PG_Stage @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (10), 
	@parm4beg smallint, @parm4end smallint as 
    Select * from cftFeedPlanInd Where FeedPlanId = @parm1 and PigGroupId = @parm2 and RoomNbr = @parm3
	and Stage Between @parm4beg and @parm4end
	Order by FeedPlanId, PigGroupId, Stage


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF311p_cftFeedPlanInd_FPId_PG_Stage] TO [MSDSL]
    AS [dbo];

