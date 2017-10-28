Create Procedure CF303p_cftFeedOrder_All as 
    Select * from cftFeedOrder

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF303p_cftFeedOrder_All] TO [MSDSL]
    AS [dbo];

