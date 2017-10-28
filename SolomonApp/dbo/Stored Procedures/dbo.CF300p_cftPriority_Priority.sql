Create Procedure CF300p_cftPriority_Priority @parm1 varchar (10) as 
    Select * from cftPriority Where Priority Like @parm1
	Order by Priority

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftPriority_Priority] TO [MSDSL]
    AS [dbo];

