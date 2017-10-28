Create Procedure CF521p_cftSCRate_PPA @parm1 varchar (16), @parm2 varchar (6), @parm3 varchar (16) as 
    Select s.*, a.* from cftSCRate s Left Join cftSCAcct a on s.AcctCat = a.AcctCat
	Where s.Project = @parm1 and s.PerPost = @parm2 and s.AcctCat Like @parm3
	Order by s.Project, s.PerPost, s.AcctCat
