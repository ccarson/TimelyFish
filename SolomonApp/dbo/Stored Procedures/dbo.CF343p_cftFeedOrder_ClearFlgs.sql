Create Procedure CF343p_cftFeedOrder_ClearFlgs @parm1 varchar (10), @parm2 varchar (6), @parm3 smalldatetime as 
    Update cftFeedOrder Set PrtFlg = 1, User6 = ''
	Where PrtFlg = 3 and User6 = @parm1 and MillId = @parm2 and DateSched = @parm3
