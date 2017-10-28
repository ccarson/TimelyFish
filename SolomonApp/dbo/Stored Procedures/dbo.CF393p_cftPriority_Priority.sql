Create Procedure CF393p_cftPriority_Priority @parm1 varchar (10) as 
    Select * from cftPriority Where Priority Like @parm1
	Order by Priority
