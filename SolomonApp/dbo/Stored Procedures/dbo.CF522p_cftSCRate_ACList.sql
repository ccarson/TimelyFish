Create Procedure CF522p_cftSCRate_ACList @parm1 varchar (16) as 
    Select * from cftSCRate Where Type = 'Production Phase' and SubType = @parm1 
	Order by AcctCat

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_cftSCRate_ACList] TO [MSDSL]
    AS [dbo];

