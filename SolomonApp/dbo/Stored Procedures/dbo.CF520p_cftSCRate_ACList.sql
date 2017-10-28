Create Procedure CF520p_cftSCRate_ACList @parm1 varchar (16), @parm2 varchar (6) as 
    Select * from cftSCRate Where Project = @parm1 and PerPost = @parm2 and Rate <> 0 
	Order by AcctCat

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF520p_cftSCRate_ACList] TO [MSDSL]
    AS [dbo];

