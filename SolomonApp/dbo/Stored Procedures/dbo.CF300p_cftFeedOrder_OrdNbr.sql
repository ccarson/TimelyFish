Create Procedure CF300p_cftFeedOrder_OrdNbr @parm1 varchar (10) as 
    Select * from cftFeedOrder Where OrdNbr Like @parm1
	Order by OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedOrder_OrdNbr] TO [MSDSL]
    AS [dbo];

