Create Procedure CF343p_cftFeedOrder_OrdNbr @parm1 varchar (10) as 
    Select * from cftFeedOrder Where OrdNbr = @parm1 
