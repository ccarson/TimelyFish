
CREATE  Procedure CF311p_cftFeedOrder_I7Cnt @parm1 varchar (4), @parm2 varchar (10) as 
    Select Count(*) from cftFeedOrder Where FeedPlanId = @parm1 and PigGroupId = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF311p_cftFeedOrder_I7Cnt] TO [MSDSL]
    AS [dbo];

