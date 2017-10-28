Create Procedure CF320p_cftFeedOrder_AllOrds @parm1 varchar (6) as 
    Select * from cftFeedOrder Where ContactId = @parm1
	Order by BinNbr, DateSched, OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF320p_cftFeedOrder_AllOrds] TO [MSDSL]
    AS [dbo];

