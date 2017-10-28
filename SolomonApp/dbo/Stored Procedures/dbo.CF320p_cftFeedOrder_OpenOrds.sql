Create Procedure CF320p_cftFeedOrder_OpenOrds @parm1 varchar (1), @parm2 varchar (1), @parm3 varchar (6) as 
    Select * from cftFeedOrder Where ContactId = @parm3 and Not (Status in (@parm1, @parm2))
	Order by BinNbr, DateSched, OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF320p_cftFeedOrder_OpenOrds] TO [MSDSL]
    AS [dbo];

